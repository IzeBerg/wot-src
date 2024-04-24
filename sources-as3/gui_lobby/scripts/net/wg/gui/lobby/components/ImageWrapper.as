package net.wg.gui.lobby.components
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ImageWrapper extends UIComponentEx
   {
       
      
      public var image:Image;
      
      private var _tooltip:String = "";
      
      public function ImageWrapper()
      {
         super();
      }
      
      public function get source() : String
      {
         return this.image.source;
      }
      
      public function set source(param1:String) : void
      {
         this.image.source = param1;
      }
      
      override protected function onDispose() : void
      {
         this.subscribe(false);
         this.image.dispose();
         this.image = null;
         super.onDispose();
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         if(this._tooltip == param1)
         {
            return;
         }
         this._tooltip = param1;
         this.subscribe(StringUtils.isNotEmpty(this._tooltip));
      }
      
      private function subscribe(param1:Boolean) : void
      {
         if(param1)
         {
            addEventListener(MouseEvent.ROLL_OVER,this.onImageRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onImageRollOutHandler);
         }
         else
         {
            removeEventListener(MouseEvent.ROLL_OUT,this.onImageRollOutHandler);
            removeEventListener(MouseEvent.ROLL_OVER,this.onImageRollOverHandler);
         }
      }
      
      private function onImageRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onImageRollOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(this._tooltip);
      }
   }
}
