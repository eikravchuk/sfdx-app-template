//@ts-check
import { auraLwcBridgeService } from 'c/auraLwcBridgeService';
import { isBackdropElement, modifyPanelComponent } from './modalUtils';
import { modalSizeClassNames } from './constants';

/**@module ModalService */

/**
 *
 * @typedef {Object} ModalParamsPromises
 * @property {Promise} [create]
 * @property {Promise} [close]
 * @property {Promise} [modalRef]
 */
/** @typedef {Object} ModalParams
 * @property {string} modalName
 * @property {string} cssClass
 * @property {boolean} [showCloseButton]
 * @property {boolean} [useAuraModalDynamicLwc]
 * @property {boolean} [backdropClose]
 * @property {*} modalData
 * @property {Object.<string,Function>} callbacks
 * @property {Object.<string,Function>} resolvers
 * @property {ModalParamsPromises} promises
 */
/**
 * @typedef {Object} ModalParamsConfig
 * @property {string} [cssClass]
 * @property {*} [modalData]
 * @property {boolean} [showCloseButton]
 * @property {boolean} [useAuraModalDynamicLwc]
 * @property {boolean} [backdropClose]
 */
/**
 * @callback ShowModalFn
 * @param {ModalParams} params
 */
/**
 * @typedef {Object} AuraModalService
 * @property {string} id
 * @property {ShowModalFn} showModal
 */

const NAMESPACE = '[MODAL SERVICE]';

/** ModalService */
class ModalService {
  modalContainerMarker = null;
  modalsMap = {};
  /**
   * @type {AuraModalService[]}
   */
  auraModalServices = [];

  get modalSizeClassNames() {
    return modalSizeClassNames;
  }

  /**
   *
   * @param {string} modalName
   * @param {ModalParamsConfig} [config]
   * @returns {ModalParams}
   */
  buildAuraModalParams(modalName, config) {
    const promisesAndResolvers = ['create', 'close', 'modalRef'].reduce(
      (acc, name) => {
        const promise = new Promise((resolve) => {
          acc.resolvers[name] = resolve;
        });
        acc.promises[name] = promise;

        return acc;
      },
      { resolvers: {}, promises: {} }
    );

    /**@type {ModalParams} */
    const params = Object.assign(
      {
        modalName: modalName,
        cssClass: 'slds-modal_small',
        useAuraModalDynamicLwc: true,
        modalData: {},
        callbacks: {},
        resolvers: {},
        promises: {}
      },
      config,
      promisesAndResolvers
    );
    return params;
  }

  /**
   *
   * @param {*} lwcElement
   * @param {ModalParams} modalParams
   */
  showModal(lwcElement, modalParams) {
    auraLwcBridgeService.showModal(modalParams);

    modalParams.promises.modalRef.then((modalRef) => {
      const panelInstance = modalRef._panelInstance;
      const panelId = panelInstance.$localIndex$.panel;
      modifyPanelComponent(panelInstance);
      this.modalsMap[panelId] = { panelId, modalRef };

      if (modalParams.backdropClose) {
        this.attachBackdropClickListener(panelInstance.$_marker$, modalRef);
      }

      modalParams.promises.close.then(() => {
        delete this.modalsMap[panelId];
      });
    });

    return modalParams.promises.close;
  }

  /**
   *
   * @param {*} containerMarker
   * @param {*} modalRef
   */
  attachBackdropClickListener(containerMarker, modalRef) {
    try {
      containerMarker.addEventListener('click', (event) => {
        /**@type {HTMLElement} */
        const target = event.target;
        if (!target) {
          return;
        }
        if (isBackdropElement(target)) {
          modalRef.close && modalRef.close();
        }
      });
    } catch (err) {
      console.error(err);
    }
  }

  /**
   *
   * @param {*} lwcElement
   * @param {*} [result]
   */
  emitCloseModal(lwcElement, result) {
    lwcElement.dispatchEvent(
      new CustomEvent('close', {
        bubbles: true,
        cancelable: true,
        composed: true,
        detail: result
      })
    );
  }
}

export const modalService = new ModalService();
export * from './constants';
