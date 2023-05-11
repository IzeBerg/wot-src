package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class AlertMessageBlockMeta extends BaseDAAPIComponent
   {
       
      
      public var onButtonClick:Function;
      
      private var _alertMessageBlockVO:AlertMessageBlockVO;
      
      public function AlertMessageBlockMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._alertMessageBlockVO)
         {
            this._alertMessageBlockVO.dispose();
            this._alertMessageBlockVO = null;
         }
         super.onDispose();
      }
      
      public function onButtonClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onButtonClick,"onButtonClick" + Errors.CANT_NULL);
         this.onButtonClick();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:AlertMessageBlockVO = this._alertMessageBlockVO;
         this._alertMessageBlockVO = new AlertMessageBlockVO(param1);
         this.setData(this._alertMessageBlockVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:AlertMessageBlockVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
