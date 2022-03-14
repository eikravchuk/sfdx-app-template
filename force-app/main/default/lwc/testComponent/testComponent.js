//@ts-check
import { LightningElement, api } from 'lwc';
import { labels } from './labels';
import { testComponentService } from './testComponentService';
import { modalService } from 'c/modalService';
import { navigationService } from 'c/navigationService';

export default class TestComponent extends LightningElement {
  isLoading = false;
  currentUser;
  htmlOutputValue = `<div><h1>Test html output</h1><p>text</p><b>bold</b></div>`;
  connectedCallback() {
    // this.fetchData();
  }

  disconnectedCallback() {}

  get labels() {
    return labels;
  }

  fetchData() {
    this.isLoading = true;
    testComponentService
      .getData()
      .then((res) => {
        this.isLoading = false;
        this.currentUser = res;
      })
      .catch(() => {
        this.isLoading = false;
      });
  }

  openModalClickHandler() {
    const modalParams = modalService.buildAuraModalParams('testComponent', {
      backdropClose: true,
      modalData: {}
    });
    modalService
      .showModal(this, modalParams)
      .then((result) => {
        console.log('closed', result);
      })
      .catch((err) => {
        console.error(err);
      });
  }

  linkClickHandler() {
    navigationService
      .getLinkInfo({
        stateType: 'standard__recordPage',
        attributes: {
          recordId: '50009000007SidVAAS',
          actionName: 'view'
        }
      })
      .then((res) => {
        console.log(res);
      })
      .catch((err) => {
        console.log(err);
      });
  }

  focusFieldHandler() {
    // console.log('focusFieldHandler');
  }

  /**
   *
   * @param {*} event
   */
  blurFieldHandler(event) {
    console.log('blurFieldHandler');
    const { detail } = event;
    console.log(JSON.stringify(detail, null, 2));
  }
}
