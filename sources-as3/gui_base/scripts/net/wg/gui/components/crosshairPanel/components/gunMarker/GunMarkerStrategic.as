package net.wg.gui.components.crosshairPanel.components.gunMarker
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.SimpleContainer;
   
   public class GunMarkerStrategic extends SimpleContainer implements IGunMarker
   {
      
      public static const NODE_TYPE_RED:String = "red";
      
      public static const NODE_TYPE_GREEN:String = "green";
       
      
      public var elem_1:MovieClip;
      
      public var elem_2:MovieClip;
      
      public var elem_3:MovieClip;
      
      public var elem_4:MovieClip;
      
      public var elem_5:MovieClip;
      
      public var elem_6:MovieClip;
      
      public var elem_7:MovieClip;
      
      public var elem_8:MovieClip;
      
      public var elem_9:MovieClip;
      
      public var elem_10:MovieClip;
      
      public var elem_11:MovieClip;
      
      public var elem_12:MovieClip;
      
      public var elem_13:MovieClip;
      
      public var elem_14:MovieClip;
      
      public var elem_15:MovieClip;
      
      public var elem_16:MovieClip;
      
      public var elem_17:MovieClip;
      
      public var elem_18:MovieClip;
      
      public var elem_19:MovieClip;
      
      public var elem_20:MovieClip;
      
      public var elem_21:MovieClip;
      
      public var elem_22:MovieClip;
      
      public var elem_23:MovieClip;
      
      public var elem_24:MovieClip;
      
      public var elem_25:MovieClip;
      
      public var elem_26:MovieClip;
      
      public var elem_27:MovieClip;
      
      public var elem_28:MovieClip;
      
      public var elem_29:MovieClip;
      
      public var elem_30:MovieClip;
      
      public var elem_31:MovieClip;
      
      public var elem_32:MovieClip;
      
      public var elem_33:MovieClip;
      
      public var elem_34:MovieClip;
      
      public var elem_35:MovieClip;
      
      public var elem_36:MovieClip;
      
      public var elem_37:MovieClip;
      
      protected var _nodes:Vector.<MovieClip>;
      
      protected var _nodesTotal:int = 0;
      
      public function GunMarkerStrategic()
      {
         this._nodes = new Vector.<MovieClip>();
         super();
         this._nodesTotal = this.numChildren;
         var _loc1_:int = 0;
         while(_loc1_ < this._nodesTotal)
         {
            this._nodes[_loc1_] = this.getChildAt(_loc1_) as MovieClip;
            _loc1_++;
         }
      }
      
      public function setReloadingParams(param1:Number, param2:String) : void
      {
         this.setCurrentReloading(param1);
      }
      
      protected function setCurrentReloading(param1:Number) : void
      {
         var _loc2_:String = param1 < 1 ? NODE_TYPE_RED : NODE_TYPE_GREEN;
         var _loc3_:int = 0;
         while(_loc3_ < this._nodesTotal)
         {
            this._nodes[_loc3_].gotoAndStop(_loc2_);
            _loc3_++;
         }
      }
      
      public function setSettings(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
      }
      
      public function setColor(param1:String) : void
      {
      }
      
      public function setScale(param1:Number) : void
      {
      }
      
      override protected function onDispose() : void
      {
         this._nodes.splice(0,this._nodes.length);
         this._nodes = null;
         super.onDispose();
      }
      
      public function setMixingScale(param1:Number) : void
      {
      }
      
      public function setDualAccActive(param1:Boolean) : void
      {
      }
      
      public function setIsSecondary(param1:Boolean) : void
      {
      }
      
      public function setExplosiveMarker(param1:Boolean) : void
      {
      }
   }
}
