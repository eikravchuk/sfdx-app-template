//@ts-check
import { executeService } from 'c/executeService';

class TestComponentService {
  getData() {
    const params = {
      actionName: 'getCurrentUser',
      recordId: 'id'
    };
    return this.request(params);
  }

  /**
   *
   * @param {*} params
   * @returns
   */
  request(params) {
    return executeService.execute('LC_ClassNameController', params);
  }
}

export const testComponentService = new TestComponentService();