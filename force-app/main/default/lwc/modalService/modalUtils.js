let isPanelModified = false;

/**@param {HTMLElement} el */
export function isBackdropElement(el) {
  const classes = ['slds-modal', 'slds-modal__container'];
  return classes.some((key) => el.classList.contains(key));
}

/**
 *
 * @param {*} panelCmp
 */
export function modifyPanelComponent(panelCmp) {
  // if (isPanelModified) {
  //   return;
  // }
  // isPanelModified = true;
  // const originalCloseBtnPressed = panelCmp.controller.onCloseBtnPressed;
  // const originalNotify = panelCmp.controller.onNotify;
  // panelCmp.controller.onCloseBtnPressed = function () {
  //   console.log('onCloseBtnPressed');
  //   originalCloseBtnPressed.apply(this, arguments);
  // };
  // panelCmp.controller.onNotify = function () {
  //   console.log('onCloseBtnPressed');
  //   originalNotify.apply(this, arguments);
  // };
}
