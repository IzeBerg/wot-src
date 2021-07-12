package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class AchievementsCustomBlockItem extends UIComponentEx
   {
       
      
      private var _data:Object = null;
      
      public var nationIco:UILoaderAlt;
      
      public var vehicleType:UILoaderAlt;
      
      public var vehicleName:TextField;
      
      public var vehicleIco:UILoaderAlt;
      
      public var levelMc:MovieClip;
      
      private var dataDirty:Boolean = false;
      
      private var _nation:Number = NaN;
      
      private var _name:String = null;
      
      private var _type:String = null;
      
      private var _level:Number = NaN;
      
      private var _ico:String = null;
      
      public function AchievementsCustomBlockItem()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this.dataDirty)
         {
            if(this._name)
            {
               this.vehicleName.text = this._name;
               this.vehicleName.width = this.vehicleName.textWidth + 5;
            }
            if(!isNaN(this._nation))
            {
               _loc1_ = "../maps/icons/filters/nations/" + App.utils.getNationNamesS()[this._nation] + ".png";
               this.nationIco.source = _loc1_;
            }
            if(this._type)
            {
               this.vehicleType.source = "../maps/icons/filters/tanks/" + this._type + ".png";
            }
            if(this._ico)
            {
               this.vehicleIco.source = this._ico;
               this.vehicleIco.sourceAlt = "../maps/icons/vehicle/small/noImage.png";
            }
            if(this._level)
            {
               this.levelMc.gotoAndStop(this._level);
            }
            this.dataDirty = false;
         }
      }
      
      public function setData(param1:Object) : void
      {
         this._data = param1;
         this._nation = this._data.nation;
         this._name = this._data.name;
         this._type = this._data.type;
         this._level = this._data.level;
         this._ico = this._data.icon;
         this.dataDirty = true;
         validateNow();
      }
      
      override public function toString() : String
      {
         return "[WG AchievementsCustomBlockItem " + name + "]";
      }
   }
}
