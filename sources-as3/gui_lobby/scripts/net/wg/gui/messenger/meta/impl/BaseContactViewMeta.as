package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.messenger.data.ContactsViewInitDataVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseContactViewMeta extends BaseDAAPIComponent
   {
       
      
      public var onOk:Function;
      
      public var onCancel:Function;
      
      private var _contactsViewInitDataVO:ContactsViewInitDataVO;
      
      public function BaseContactViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._contactsViewInitDataVO)
         {
            this._contactsViewInitDataVO.dispose();
            this._contactsViewInitDataVO = null;
         }
         super.onDispose();
      }
      
      public function onOkS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.onOk,"onOk" + Errors.CANT_NULL);
         this.onOk(param1);
      }
      
      public function onCancelS() : void
      {
         App.utils.asserter.assertNotNull(this.onCancel,"onCancel" + Errors.CANT_NULL);
         this.onCancel();
      }
      
      public final function as_setInitData(param1:Object) : void
      {
         var _loc2_:ContactsViewInitDataVO = this._contactsViewInitDataVO;
         this._contactsViewInitDataVO = this.getContactsViewInitDataVOForData(param1);
         this.setInitData(this._contactsViewInitDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getContactsViewInitDataVOForData(param1:Object) : ContactsViewInitDataVO
      {
         var _loc2_:String = "getContactsViewInitDataVOForData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setInitData(param1:ContactsViewInitDataVO) : void
      {
         var _loc2_:String = "as_setInitData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
