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
       
      
      private const _imageRepository:ImageRepository = ImageRepository.getInstance();
      
      public var engravingStatName:TextField = null;
      
      private var _characters:Array;
      
      private var _engravingStatValueContainer:Sprite;
      
      private var _plate:Image = null;
      
      public function DogtagDownPlate()
      {
         this._characters = [];
         super();
         this._engravingStatValueContainer = new Sprite();
         this._plate = new Image();
         this._engravingStatValueContainer = new Sprite();
      }
      
      override protected function configUI() : void
      {
         addChildAt(this._plate,0);
         this._engravingStatValueContainer.y = ENGRAVING_STAT_VALUE_CONTAINER_OFFSET_Y;
         addChild(this._engravingStatValueContainer);
         super.configUI();
      }
      
      public function setDogTagInfo(param1:String, param2:String) : void
      {
         this._plate.bitmapData = this._imageRepository.getImageBitmapData(DEFAULT_BACKGROUND);
         this.engravingStatName.text = param1;
         this.buildPhrase(param2);
      }
      
      private function buildPhrase(param1:String) : void
      {
         var _loc4_:String = null;
         var _loc5_:Image = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:String = null;
         this.removeCharacters();
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1.charAt(_loc3_);
            if(_loc4_ == SPACE)
            {
               _loc2_ += SPACE_GAP;
            }
            else
            {
               _loc5_ = new Image();
               if(_loc4_ == BRACKET_LEFT)
               {
                  _loc6_ = param1.indexOf(BRACKET_RIGHT,_loc3_);
                  _loc7_ = _loc6_ - _loc3_ - 1;
                  _loc8_ = param1.substr(_loc3_ + 1,_loc7_);
                  _loc4_ = _loc8_;
                  _loc3_ += _loc7_ + 1;
               }
               _loc5_.bitmapData = this._imageRepository.getCharacterBitmapData(_loc4_);
               _loc5_.x = _loc2_;
               this._engravingStatValueContainer.addChild(_loc5_);
               this._characters.push(_loc5_);
               _loc2_ += _loc5_.bitmapData.width;
            }
            _loc3_++;
         }
         this._engravingStatValueContainer.x = (this.width >> 1) - (_loc2_ >> 1);
      }
      
      override protected function onDispose() : void
      {
         this._plate.dispose();
         this._plate = null;
         this.removeCharacters();
         this._engravingStatValueContainer = null;
         this._characters = null;
         super.onDispose();
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
