package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.BrowserVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BrowserScreenMeta extends AbstractView
   {
       
      
      public var onCloseBtnClick:Function;
      
      public var onEscapePress:Function;
      
      public var onFocusChange:Function;
      
      public var viewSize:Function;
      
      private var _browserVO:BrowserVO;
      
      public function BrowserScreenMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._browserVO)
         {
            this._browserVO.dispose();
            this._browserVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
         this.onCloseBtnClick();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public function onFocusChangeS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onFocusChange,"onFocusChange" + Errors.CANT_NULL);
         this.onFocusChange(param1);
      }
      
      public function viewSizeS(param1:Number, param2:Number) : void
      {
         App.utils.asserter.assertNotNull(this.viewSize,"viewSize" + Errors.CANT_NULL);
         this.viewSize(param1,param2);
      }
      
      public final function as_setBrowserParams(param1:Object) : void
      {
         var _loc2_:BrowserVO = this._browserVO;
         this._browserVO = new BrowserVO(param1);
         this.setBrowserParams(this._browserVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setBrowserParams(param1:BrowserVO) : void
      {
         var _loc2_:String = "as_setBrowserParams" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
