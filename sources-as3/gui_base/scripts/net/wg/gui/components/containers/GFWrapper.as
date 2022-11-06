package net.wg.gui.components.containers
{
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldType;
   
   public class GFWrapper extends BaseContainerWrapper
   {
      
      public static const GF_WRAPPER_NAME:String = "GFWrapper";
      
      private static const BITMAP_NAME:String = "gamefaceBitmap";
      
      private static const TF_NAME:String = "gfInputFixTF";
      
      private static const IME_TF_NAME:String = "gfimeTF";
      
      private static const HIT_AREA_SPRITE:String = "hitAreaSprite";
      
      public static const UPDATE_STAGE_EVENT:String = "updateStage";
       
      
      public var inputFixTF:TextField = null;
      
      public var imeTF:TextField = null;
      
      public var gamefaceBitmap:Bitmap = null;
      
      public function GFWrapper()
      {
         super();
         name = GF_WRAPPER_NAME;
         this.addGFBitmap();
         this.addInputFixTF();
         this.addIMETF();
         this.addHitArea();
      }
      
      public static function createWrapper() : GFWrapper
      {
         return new GFWrapper();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         if(_width == param1 && _height == param2)
         {
            return;
         }
         _width = param1;
         _height = param2;
         if(this.inputFixTF != null)
         {
            this.inputFixTF.width = param1;
            this.inputFixTF.height = param2;
         }
         if(this.gamefaceBitmap != null)
         {
            this.gamefaceBitmap.width = param1;
            this.gamefaceBitmap.height = param2;
         }
         if(hitArea != null)
         {
            hitArea.width = param1;
            hitArea.height = param2;
         }
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         dispatchEvent(new Event(UPDATE_STAGE_EVENT));
      }
      
      override protected function onDispose() : void
      {
         this.gamefaceBitmap = null;
         this.inputFixTF = null;
         this.imeTF = null;
         removeChild(hitArea);
         hitArea = null;
         super.onDispose();
      }
      
      private function addGFBitmap() : void
      {
         this.gamefaceBitmap = new Bitmap();
         this.gamefaceBitmap.name = BITMAP_NAME;
         addChild(this.gamefaceBitmap);
      }
      
      private function addInputFixTF() : void
      {
         this.inputFixTF = new TextField();
         this.inputFixTF.name = TF_NAME;
         this.inputFixTF.maxChars = 1;
         this.inputFixTF.alpha = 0;
         this.inputFixTF.type = TextFieldType.DYNAMIC;
         this.inputFixTF.selectable = false;
         this.inputFixTF.width = this.inputFixTF.height = 0;
         addChild(this.inputFixTF);
      }
      
      private function addIMETF() : void
      {
         this.imeTF = new TextField();
         this.imeTF.name = IME_TF_NAME;
         this.imeTF.maxChars = 1;
         this.imeTF.alpha = 0;
         this.imeTF.type = TextFieldType.INPUT;
         this.imeTF.selectable = false;
      }
      
      private function addHitArea() : void
      {
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = HIT_AREA_SPRITE;
         _loc1_.graphics.clear();
         _loc1_.graphics.beginFill(16711680,0);
         _loc1_.graphics.drawRect(0,0,1,1);
         _loc1_.graphics.endFill();
         addChild(_loc1_);
         hitArea = _loc1_;
      }
   }
}
