package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BSClanUnitName extends MovieClip implements IDisposable
   {
      
      private static const ALPHABET:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
      
      private static const NAME_UNIT_HIT_AREA:String = "unitNameHitArea";
       
      
      public var letterTF:TextField = null;
      
      public var glow:MovieClip = null;
      
      private var _unitNameHitArea:Sprite;
      
      public function BSClanUnitName()
      {
         super();
         this._unitNameHitArea = new Sprite();
         this._unitNameHitArea.name = NAME_UNIT_HIT_AREA;
         addChild(this._unitNameHitArea);
         this.glow.hitArea = this._unitNameHitArea;
      }
      
      public function dispose() : void
      {
         this.glow.hitArea = null;
         removeChild(this._unitNameHitArea);
         this._unitNameHitArea = null;
         this.glow = null;
         this.letterTF = null;
      }
      
      public function updateData(param1:int) : void
      {
         var _loc2_:int = param1 + 1;
         gotoAndStop(_loc2_);
         this.glow.gotoAndStop(_loc2_);
         this.letterTF.text = ALPHABET.charAt(param1);
      }
   }
}
