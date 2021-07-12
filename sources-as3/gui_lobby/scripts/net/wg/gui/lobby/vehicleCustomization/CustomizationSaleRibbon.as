package net.wg.gui.lobby.vehicleCustomization
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class CustomizationSaleRibbon extends UIComponentEx
   {
       
      
      public var salesText:TextField = null;
      
      public var saleRibbonImage:MovieClip = null;
      
      public function CustomizationSaleRibbon()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.disableHitArea(this);
         this.disableHitArea(this.salesText);
         this.disableHitArea(this.saleRibbonImage);
      }
      
      override protected function onDispose() : void
      {
         this.salesText = null;
         this.saleRibbonImage = null;
         super.onDispose();
      }
      
      public function setSaleText(param1:String) : void
      {
         this.salesText.text = param1;
      }
      
      private function disableHitArea(param1:InteractiveObject) : void
      {
         var _loc2_:Sprite = null;
         var _loc3_:Sprite = null;
         _loc2_ = param1 as Sprite;
         param1.mouseEnabled = false;
         if(_loc2_ != null)
         {
            _loc2_.mouseChildren = false;
            _loc3_ = new Sprite();
            _loc2_.addChild(_loc3_);
            _loc2_.hitArea = _loc3_;
            _loc2_.hitArea.visible = false;
         }
      }
   }
}
