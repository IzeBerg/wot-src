package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BSUnitInfo extends MovieClip implements IDisposable
   {
      
      private static const LABEL_PREFIX_LEVEL:String = "level";
      
      private static const X_LEVEL_WIDE:uint = 17;
      
      private static const X_LEVEL_NORMAL:uint = 14;
      
      private static const WIDTH_DEFAULT:uint = 31;
      
      private static const WIDTH_WIDE:uint = 26;
      
      private static const WIDTH_NORMAL:uint = 22;
      
      private static const WIDTH_SHORT:uint = 20;
       
      
      public var unitName:BSClanUnitName = null;
      
      public var vehicleLevel:MovieClip;
      
      public var hitAreaMc:Sprite;
      
      private var _vehicleLevel:uint = 0;
      
      private var _adaptiveWidth:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function BSUnitInfo()
      {
         super();
         this.hitArea = this.hitAreaMc;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.unitName.dispose();
         this.unitName = null;
         this.vehicleLevel = null;
         this.hitArea = null;
         this.hitAreaMc = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function updateData(param1:int, param2:int, param3:Boolean = false) : void
      {
         this._vehicleLevel = param2;
         this._adaptiveWidth = param3;
         this.unitName.updateData(param1,param3);
         this.vehicleLevel.gotoAndStop(LABEL_PREFIX_LEVEL + param2);
         this.updateWidth();
      }
      
      private function updateWidth() : void
      {
         var _loc1_:uint = WIDTH_DEFAULT;
         this.vehicleLevel.x = !!this._adaptiveWidth ? Number(X_LEVEL_WIDE) : Number(X_LEVEL_NORMAL);
         if(this._adaptiveWidth && this._vehicleLevel > Values.ZERO)
         {
            switch(this._vehicleLevel)
            {
               case 6:
                  _loc1_ = WIDTH_NORMAL;
                  break;
               case 8:
                  _loc1_ = WIDTH_WIDE;
                  break;
               case 10:
                  _loc1_ = WIDTH_SHORT;
            }
         }
         if(this.hitAreaMc.width != _loc1_)
         {
            this.hitAreaMc.width = _loc1_;
         }
      }
      
      override public function get width() : Number
      {
         return this.hitAreaMc.width;
      }
      
      override public function get height() : Number
      {
         return this.hitAreaMc.height;
      }
   }
}
