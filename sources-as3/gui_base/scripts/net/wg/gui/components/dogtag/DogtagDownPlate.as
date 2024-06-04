package net.wg.gui.components.dogtag
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class DogtagDownPlate extends UIComponentEx
   {
      
      private static const SPACE_GAP:int = 5;
      
      private static const ENGRAVING_STAT_VALUE_CONTAINER_OFFSET_Y:int = 70;
      
      private static const BRACKET_LEFT:String = "[";
      
      private static const BRACKET_RIGHT:String = "]";
      
      private static const SPACE:String = " ";
      
      private static const DEFAULT_BACKGROUND:String = "background_66_0";
      
      private static const DEFAULT_DOGTAG_FRAME_LABEL:String = "default";
      
      private static const ANIMATED_DOGTAG_FRAME_LABEL:String = "animated";
       
      
      public var engravingStatName:TextField = null;
      
      public var engravingStatValue:TextField = null;
      
      private var _characters:Vector.<Image>;
      
      private var _plate:Image;
      
      private var _engravingStatValueContainer:Sprite;
      
      private var _imageRepository:ImageRepository;
      
      public function DogtagDownPlate()
      {
         this._characters = new Vector.<Image>();
         this._plate = new Image();
         this._engravingStatValueContainer = new Sprite();
         this._imageRepository = ImageRepository.getInstance();
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addChildAt(this._plate,0);
         addChild(this._engravingStatValueContainer);
         this._engravingStatValueContainer.y = ENGRAVING_STAT_VALUE_CONTAINER_OFFSET_Y;
      }
      
      override protected function onDispose() : void
      {
         this.engravingStatValue = null;
         this.engravingStatName = null;
         this._plate.dispose();
         this._plate = null;
         this.removeCharacters();
         this._engravingStatValueContainer = null;
         this._imageRepository = null;
         this._characters.length = 0;
         this._characters = null;
         super.onDispose();
      }
      
      public function setDogTagInfo(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         this.gotoAndStop(!!param4 ? ANIMATED_DOGTAG_FRAME_LABEL : DEFAULT_DOGTAG_FRAME_LABEL);
         this._plate.bitmapData = this._imageRepository.getImageBitmapData(Boolean(param3) ? param3 : DEFAULT_BACKGROUND);
         this.engravingStatName.text = param1;
         if(param4)
         {
            this.engravingStatValue.text = param2;
         }
         else
         {
            this.buildPhrase(param2);
         }
      }
      
      private function buildPhrase(param1:String) : void
      {
         var _loc5_:String = null;
         var _loc6_:Image = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:String = null;
         this.removeCharacters();
         var _loc2_:int = 0;
         var _loc3_:int = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = param1.charAt(_loc4_);
            if(_loc5_ == SPACE)
            {
               _loc2_ += SPACE_GAP;
            }
            else
            {
               _loc6_ = new Image();
               if(_loc5_ == BRACKET_LEFT)
               {
                  _loc7_ = param1.indexOf(BRACKET_RIGHT,_loc4_);
                  _loc8_ = _loc7_ - _loc4_ - 1;
                  _loc9_ = param1.substr(_loc4_ + 1,_loc8_);
                  _loc5_ = _loc9_;
                  _loc4_ += _loc8_ + 1;
               }
               _loc6_.bitmapData = this._imageRepository.getCharacterBitmapData(_loc5_);
               _loc6_.x = _loc2_;
               this._engravingStatValueContainer.addChild(_loc6_);
               this._characters.push(_loc6_);
               _loc2_ += _loc6_.bitmapData.width;
            }
            _loc4_++;
         }
         this._engravingStatValueContainer.x = (this.width >> 1) - (_loc2_ >> 1);
      }
      
      private function removeCharacters() : void
      {
         var _loc3_:* = undefined;
         var _loc1_:int = this._characters.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = this._characters.pop();
            this._engravingStatValueContainer.removeChild(_loc3_);
            _loc3_.dispose();
            _loc2_++;
         }
      }
   }
}
