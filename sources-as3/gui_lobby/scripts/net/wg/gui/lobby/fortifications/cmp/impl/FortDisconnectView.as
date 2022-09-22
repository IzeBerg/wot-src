package net.wg.gui.lobby.fortifications.cmp.impl
{
   import flash.display.InteractiveObject;
   import flash.geom.Point;
   import flash.text.TextField;
   import net.wg.gui.lobby.fortifications.cmp.IFortDisconnectView;
   import net.wg.infrastructure.base.meta.impl.FortDisconnectViewMeta;
   import net.wg.infrastructure.events.FocusRequestEvent;
   
   public class FortDisconnectView extends FortDisconnectViewMeta implements IFortDisconnectView
   {
      
      private static const DESCR_Y_OFFSET:int = 24;
      
      public static const INVALID_TEXTS:String = "invalidTexts";
       
      
      public var warningText:TextField = null;
      
      public var warningDescription:TextField = null;
      
      private var _warningTxt:String = null;
      
      private var _warningDescTxt:String = null;
      
      public function FortDisconnectView()
      {
         super();
      }
      
      public function as_setWarningTexts(param1:String, param2:String) : void
      {
         this._warningTxt = param1;
         this._warningDescTxt = param2;
         invalidate(INVALID_TEXTS);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         dispatchEvent(new FocusRequestEvent(FocusRequestEvent.REQUEST_FOCUS,this));
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         super.draw();
         if(this.warningText && this.warningDescription)
         {
            this.warningText.width = this.warningDescription.width = App.appWidth;
            _loc1_ = localToGlobal(new Point(0,0)).y;
            this.warningText.y = (App.appHeight >> 1) - this.warningText.height - _loc1_;
            this.warningDescription.y = this.warningText.y + this.warningText.height + DESCR_Y_OFFSET;
            if(isInvalid(INVALID_TEXTS))
            {
               this.warningText.htmlText = this._warningTxt;
               this.warningDescription.htmlText = this._warningDescTxt;
            }
         }
         else
         {
            invalidate(INVALID_TEXTS);
         }
      }
      
      override protected function onDispose() : void
      {
         this.warningText = null;
         this.warningDescription = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return this;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
   }
}
