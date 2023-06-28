package net.wg.gui.messenger.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.messenger.data.ContactUserPropVO;
   import net.wg.gui.messenger.views.BaseManageContactView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ContactNoteManageViewMeta extends BaseManageContactView
   {
       
      
      public var sendData:Function;
      
      private var _contactUserPropVO:ContactUserPropVO;
      
      public function ContactNoteManageViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._contactUserPropVO)
         {
            this._contactUserPropVO.dispose();
            this._contactUserPropVO = null;
         }
         super.onDispose();
      }
      
      public function sendDataS(param1:Object) : void
      {
         App.utils.asserter.assertNotNull(this.sendData,"sendData" + Errors.CANT_NULL);
         this.sendData(param1);
      }
      
      public final function as_setUserProps(param1:Object) : void
      {
         var _loc2_:ContactUserPropVO = this._contactUserPropVO;
         this._contactUserPropVO = new ContactUserPropVO(param1);
         this.setUserProps(this._contactUserPropVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setUserProps(param1:ContactUserPropVO) : void
      {
         var _loc2_:String = "as_setUserProps" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
