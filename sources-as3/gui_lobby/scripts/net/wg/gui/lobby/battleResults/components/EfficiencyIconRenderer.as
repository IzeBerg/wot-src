package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.filters.ColorMatrixFilter;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class EfficiencyIconRenderer extends UIComponentEx
   {
      
      private static const MAX_FORMATTED_VALUE:String = "99K";
      
      private static const THOUSANDS_POSTFIX:String = "K";
      
      private static const THOUSANDS_VALUE:int = 1000;
      
      private static const MAX_VALUE:int = 99000;
       
      
      public var iconMc:MovieClip;
      
      public var iconLabelMc:MovieClip;
      
      private var _kind:String = "kill";
      
      private var _kindDirty:Boolean = true;
      
      private var _value:Number = 0;
      
      private var _valueDirty:Boolean = true;
      
      private var _disabledDirty:Boolean = true;
      
      public function EfficiencyIconRenderer()
      {
         super();
         buttonMode = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:ColorMatrixFilter = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         super.draw();
         if(this._disabledDirty)
         {
            if(!enabled)
            {
               _loc1_ = new ColorMatrixFilter();
               _loc2_ = [0.3,0.59,0.11,0,0];
               _loc3_ = [0.3,0.59,0.11,0,0];
               _loc4_ = [0.3,0.59,0.11,0,0];
               _loc5_ = [0,0,0,0.2,0];
               _loc6_ = [];
               _loc6_ = _loc6_.concat(_loc2_);
               _loc6_ = _loc6_.concat(_loc3_);
               _loc6_ = _loc6_.concat(_loc4_);
               _loc6_ = _loc6_.concat(_loc5_);
               _loc1_.matrix = _loc6_;
               this.filters = [_loc1_];
               this.iconMc.alpha = 0.1;
            }
            else
            {
               filters = [];
               this.iconMc.alpha = 1;
            }
            this.iconLabelMc.visible = enabled;
            this._disabledDirty = false;
         }
         if(this._kindDirty)
         {
            this.iconMc.gotoAndStop(this.kind);
            this._kindDirty = false;
         }
         if(this._valueDirty)
         {
            this.iconLabelMc.countLabel.text = this.formatValue();
            this._valueDirty = false;
         }
         this.iconLabelMc.visible = enabled && this.value > 1;
      }
      
      override protected function onDispose() : void
      {
         this.iconMc = null;
         this.iconLabelMc = null;
         super.onDispose();
      }
      
      private function formatValue() : String
      {
         if(this._value > THOUSANDS_VALUE)
         {
            if(this._value < MAX_VALUE)
            {
               return int(this._value / THOUSANDS_VALUE) + THOUSANDS_POSTFIX;
            }
            return MAX_FORMATTED_VALUE;
         }
         return this._value.toString();
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         this._disabledDirty = true;
         super.enabled = param1;
         mouseEnabled = true;
         invalidate();
      }
      
      [Inspectable(defaultValue="kill",enumeration="evil,spotted,damage,crits,teamKill,kill,medal,assist,armor,defence,capture,assistStun")]
      public function get kind() : String
      {
         return this._kind;
      }
      
      public function set kind(param1:String) : void
      {
         this._kind = param1;
         this._kindDirty = true;
         invalidate();
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      public function set value(param1:Number) : void
      {
         this._value = param1;
         this._valueDirty = true;
         invalidate();
      }
   }
}
