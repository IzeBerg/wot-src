package net.wg.gui.battle.components
{
   import flash.display.Sprite;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   
   public class BattleAtlasSprite extends Sprite
   {
       
      
      protected var _imageName:String = "";
      
      protected var _imageAltName:String = "";
      
      protected var _isFilled:Boolean = false;
      
      protected var _drawImmediately:Boolean = false;
      
      private var _defaultPosX:int = -1;
      
      private var _isCentralizeByX:Boolean = false;
      
      private var _isCentralize:Boolean = false;
      
      private var _isSmoothingEnabled:Boolean = false;
      
      private var _atlasName:String = "";
      
      public function BattleAtlasSprite(param1:Boolean = false)
      {
         super();
         this._atlasName = this.initAtlas();
      }
      
      public function drawImmediately() : void
      {
         this._drawImmediately = true;
         if(!this._isFilled && this._imageName)
         {
            this.fill(this._imageName,this._imageAltName);
         }
      }
      
      public function setImageNames(param1:String, param2:String) : void
      {
         if(this._imageName == param1 && this._imageAltName == param2)
         {
            return;
         }
         this._imageName = param1;
         this._imageAltName = param2;
         this._isFilled = false;
         if(visible || this._drawImmediately)
         {
            this.fill(this._imageName,this._imageAltName);
         }
      }
      
      protected function initAtlas() : String
      {
         return ATLAS_CONSTANTS.BATTLE_ATLAS;
      }
      
      private function fill(param1:String, param2:String) : void
      {
         if(App.atlasMgr)
         {
            App.atlasMgr.drawGraphics(this._atlasName,param1,graphics,param2,this._isSmoothingEnabled,false,this._isCentralize);
         }
         this._isFilled = true;
         if(!this._isCentralize && this._isCentralizeByX)
         {
            x = this._defaultPosX - (width >> 2);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 == visible)
         {
            return;
         }
         if(param1 && !this._isFilled && this._imageName)
         {
            this.fill(this._imageName,this._imageAltName);
         }
         super.visible = param1;
      }
      
      public function get imageName() : String
      {
         return this._imageName;
      }
      
      public function set imageName(param1:String) : void
      {
         if(this._imageName == param1)
         {
            return;
         }
         this._imageName = param1;
         this._isFilled = false;
         if(visible || this._drawImmediately)
         {
            this.fill(this._imageName,this._imageAltName);
         }
      }
      
      public function set isCentralizeByX(param1:Boolean) : void
      {
         this._isCentralizeByX = param1;
         if(this._isCentralizeByX)
         {
            this._defaultPosX = x;
         }
      }
      
      public function set isCentralize(param1:Boolean) : void
      {
         this._isCentralize = param1;
      }
      
      public function set isSmoothingEnabled(param1:Boolean) : void
      {
         this._isSmoothingEnabled = param1;
      }
   }
}
