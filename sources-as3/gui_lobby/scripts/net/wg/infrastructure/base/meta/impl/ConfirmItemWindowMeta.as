package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.DialogSettingsVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.window.ConfirmItemWindowVO;
   import net.wg.infrastructure.base.AbstractConfirmItemDialog;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ConfirmItemWindowMeta extends AbstractConfirmItemDialog
   {
       
      
      public var submit:Function;
      
      private var _confirmItemWindowVO:ConfirmItemWindowVO;
      
      private var _dialogSettingsVO:DialogSettingsVO;
      
      public function ConfirmItemWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._confirmItemWindowVO)
         {
            this._confirmItemWindowVO.dispose();
            this._confirmItemWindowVO = null;
         }
         if(this._dialogSettingsVO)
         {
            this._dialogSettingsVO.dispose();
            this._dialogSettingsVO = null;
         }
         super.onDispose();
      }
      
      public function submitS(param1:Number, param2:String) : void
      {
         App.utils.asserter.assertNotNull(this.submit,"submit" + Errors.CANT_NULL);
         this.submit(param1,param2);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:ConfirmItemWindowVO = this._confirmItemWindowVO;
         this._confirmItemWindowVO = this.getConfirmItemWindowVOForValue(param1);
         this.setData(this._confirmItemWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setSettings(param1:Object) : void
      {
         var _loc2_:DialogSettingsVO = this._dialogSettingsVO;
         this._dialogSettingsVO = new DialogSettingsVO(param1);
         this.setSettings(this._dialogSettingsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function getConfirmItemWindowVOForValue(param1:Object) : ConfirmItemWindowVO
      {
         var _loc2_:String = "getConfirmItemWindowVOForValue" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:ConfirmItemWindowVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setSettings(param1:DialogSettingsVO) : void
      {
         var _loc2_:String = "as_setSettings" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
