package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BSClanUnitName extends MovieClip implements IDisposable
   {
      
      private static const NAME_UNIT_HIT_AREA:String = "unitNameHitArea";
      
      private static const UNIT_NUMBER_LIMIT:uint = 20;
      
      private static const X_GLOW_ADAPTED:uint = 4;
      
      private static const X_GLOW_NORMAL:uint = 0;
       
      
      public var glow:MovieClip = null;
      
      private var _unitNameHitArea:Sprite;
      
      private var _disposed:Boolean = false;
      
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
         this._disposed = true;
         this.glow.hitArea = null;
         removeChild(this._unitNameHitArea);
         this._unitNameHitArea = null;
         this.glow = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function updateData(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:uint = param1 < UNIT_NUMBER_LIMIT ? uint(param1) : uint(Values.ZERO);
         this.glow.gotoAndStop(_loc3_ + 1);
         this.glow.x = !!param2 ? Number(X_GLOW_ADAPTED) : Number(X_GLOW_NORMAL);
      }
   }
}
