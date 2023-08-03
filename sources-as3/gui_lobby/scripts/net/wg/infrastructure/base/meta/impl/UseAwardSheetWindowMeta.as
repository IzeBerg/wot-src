package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.VO.DialogSettingsVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.personalMissions.data.UseAwardSheetWindowVO;
   import net.wg.infrastructure.base.AbstractWindowView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class UseAwardSheetWindowMeta extends AbstractWindowView
   {
       
      
      public var accept:Function;
      
      public var cancel:Function;
      
      private var _dialogSettingsVO:DialogSettingsVO;
      
      private var _useAwardSheetWindowVO:UseAwardSheetWindowVO;
      
      public function UseAwardSheetWindowMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._dialogSettingsVO)
         {
            this._dialogSettingsVO.dispose();
            this._dialogSettingsVO = null;
         }
         if(this._useAwardSheetWindowVO)
         {
            this._useAwardSheetWindowVO.dispose();
            this._useAwardSheetWindowVO = null;
         }
         super.onDispose();
      }
      
      public function acceptS() : void
      {
         App.utils.asserter.assertNotNull(this.accept,"accept" + Errors.CANT_NULL);
         this.accept();
      }
      
      public function cancelS() : void
      {
         App.utils.asserter.assertNotNull(this.cancel,"cancel" + Errors.CANT_NULL);
         this.cancel();
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
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:UseAwardSheetWindowVO = this._useAwardSheetWindowVO;
         this._useAwardSheetWindowVO = new UseAwardSheetWindowVO(param1);
         this.setData(this._useAwardSheetWindowVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setSettings(param1:DialogSettingsVO) : void
      {
         var _loc2_:String = "as_setSettings" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setData(param1:UseAwardSheetWindowVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
