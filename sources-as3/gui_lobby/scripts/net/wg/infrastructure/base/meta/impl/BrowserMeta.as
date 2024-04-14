package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   
   public class BrowserMeta extends BaseDAAPIComponent
   {
       
      
      public var browserAction:Function;
      
      public var browserMove:Function;
      
      public var browserDown:Function;
      
      public var browserUp:Function;
      
      public var browserFocusOut:Function;
      
      public var onBrowserShow:Function;
      
      public var onBrowserHide:Function;
      
      public var invalidateView:Function;
      
      public var setBrowserSize:Function;
      
      public function BrowserMeta()
      {
         super();
      }
      
      public function browserActionS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.browserAction,"browserAction" + Errors.CANT_NULL);
         this.browserAction(param1);
      }
      
      public function browserMoveS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.browserMove,"browserMove" + Errors.CANT_NULL);
         this.browserMove(param1,param2,param3);
      }
      
      public function browserDownS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.browserDown,"browserDown" + Errors.CANT_NULL);
         this.browserDown(param1,param2,param3);
      }
      
      public function browserUpS(param1:int, param2:int, param3:int) : void
      {
         App.utils.asserter.assertNotNull(this.browserUp,"browserUp" + Errors.CANT_NULL);
         this.browserUp(param1,param2,param3);
      }
      
      public function browserFocusOutS() : void
      {
         App.utils.asserter.assertNotNull(this.browserFocusOut,"browserFocusOut" + Errors.CANT_NULL);
         this.browserFocusOut();
      }
      
      public function onBrowserShowS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.onBrowserShow,"onBrowserShow" + Errors.CANT_NULL);
         this.onBrowserShow(param1);
      }
      
      public function onBrowserHideS() : void
      {
         App.utils.asserter.assertNotNull(this.onBrowserHide,"onBrowserHide" + Errors.CANT_NULL);
         this.onBrowserHide();
      }
      
      public function invalidateViewS() : void
      {
         App.utils.asserter.assertNotNull(this.invalidateView,"invalidateView" + Errors.CANT_NULL);
         this.invalidateView();
      }
      
      public function setBrowserSizeS(param1:int, param2:int, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.setBrowserSize,"setBrowserSize" + Errors.CANT_NULL);
         this.setBrowserSize(param1,param2,param3);
      }
   }
}
