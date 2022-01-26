package net.wg.gui.prebattle.battleSession
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BSUnitInfo extends MovieClip implements IDisposable
   {
       
      
      public var unitName:BSClanUnitName = null;
      
      public var vehicleLevel:MovieClip;
      
      public var hitAreaMc:Sprite;
      
      private var _vehicleLevel:uint = 0;
      
      private var _wideGap:Boolean = false;
      
      private var _adaptiveWidth:Boolean = false;
      
      private const LABEL_PREFIX_LEVEL:String = "level";
      
      private const X_LEVEL_WIDE:uint = 17;
      
      private const X_LEVEL_NORMAL:uint = 14;
      
      private const WIDTH_DEFAULT:uint = 31;
      
      private const WIDTH_WIDE:uint = 26;
      
      private const WIDTH_NORMAL:uint = 22;
      
      private const WIDTH_SHORT:uint = 20;
      
      public function BSUnitInfo()
      {
         super();
         this.hitArea = this.hitAreaMc;
      }
      
      public function dispose() : void
      {
         this.unitName.dispose();
         this.unitName = null;
         this.vehicleLevel = null;
         this.hitArea = null;
         this.hitAreaMc = null;
      }
      
      private function updateGap() : void
      {
         this.vehicleLevel.x = !!this._wideGap ? Number(this.X_LEVEL_WIDE) : Number(this.X_LEVEL_NORMAL);
      }
      
      private function updateWidth() : void
      {
         var _loc1_:uint = this.WIDTH_DEFAULT;
         if(this._adaptiveWidth && this._vehicleLevel > Values.ZERO)
         {
            switch(this._vehicleLevel)
            {
               case 6:
                  _loc1_ = this.WIDTH_NORMAL;
                  break;
               case 8:
                  _loc1_ = this.WIDTH_WIDE;
                  break;
               case 10:
                  _loc1_ = this.WIDTH_SHORT;
            }
         }
         if(this.hitAreaMc.width != _loc1_)
         {
            this.hitAreaMc.width = _loc1_;
         }
      }
      
      public function updateData(param1:int, param2:int, param3:Boolean = false) : void
      {
         this._vehicleLevel = param2;
         this._adaptiveWidth = param3;
         this.unitName.updateData(param1);
         this.vehicleLevel.gotoAndStop(this.LABEL_PREFIX_LEVEL + param2);
         this.updateWidth();
      }
      
      override public function get width() : Number
      {
         return this.hitAreaMc.width;
      }
      
      override public function get height() : Number
      {
         return this.hitAreaMc.height;
      }
      
      public function get wideGap() : Boolean
      {
         return this._wideGap;
      }
      
      public function set wideGap(param1:Boolean) : void
      {
         if(this._wideGap != param1)
         {
            this._wideGap = param1;
            this.updateGap();
         }
      }
   }
}
