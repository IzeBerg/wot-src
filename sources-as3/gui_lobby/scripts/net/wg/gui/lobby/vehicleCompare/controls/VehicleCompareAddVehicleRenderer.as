package net.wg.gui.lobby.vehicleCompare.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.gui.lobby.vehicleCompare.data.VehicleCompareVehicleSelectorItemVO;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleCompareAddVehicleRenderer extends ListItemRenderer
   {
      
      private static const VEH_TYPE_MIDDLE_X:int = 113;
      
      private static const NATION_ICONS_PATH:String = "../maps/icons/filters/nations/";
      
      private static const PNG:String = ".png";
       
      
      public var checkBox:CheckBox;
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var inHangar:UILoaderAlt;
      
      public var vehicleTypeIcon:IImage;
      
      public var levelIcon:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      private var _model:VehicleCompareVehicleSelectorItemVO = null;
      
      public function VehicleCompareAddVehicleRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this._model = VehicleCompareVehicleSelectorItemVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.checkBox.dispose();
         this.flagLoader.dispose();
         this.tankIcon.dispose();
         this.inHangar.dispose();
         this._model = null;
         this.vehicleNameTF = null;
         this.levelIcon = null;
         this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this.checkBox = null;
         this.flagLoader = null;
         this.tankIcon = null;
         this.inHangar = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._model != null;
            if(_loc1_)
            {
               this.checkBox.selected = this._model.selected;
               this.vehicleNameTF.htmlText = this._model.shortUserName;
               this.vehicleTypeIcon.source = this._model.typeIcon;
               this.levelIcon.gotoAndStop(this._model.level);
               this.flagLoader.source = NATION_ICONS_PATH + App.utils.nations.getNationName(this._model.nationID) + PNG;
               this.tankIcon.source = this._model.smallIconPath;
               this.inHangar.visible = this._model.inHangar;
            }
            this.checkBox.visible = _loc1_;
            this.vehicleNameTF.visible = _loc1_;
            this.vehicleTypeIcon.visible = _loc1_;
            this.levelIcon.visible = _loc1_;
            this.flagLoader.visible = _loc1_;
            this.tankIcon.visible = _loc1_;
            if(!_loc1_)
            {
               this.inHangar.visible = false;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.inHangar.source = RES_ICONS.MAPS_ICONS_BUTTONS_ICON_TABLE_COMPARISON_CHECKMARK;
         this.vehicleTypeIcon.addEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
      }
      
      override public function set height(param1:Number) : void
      {
      }
      
      private function onVehicleTypeIconChangeHandler(param1:Event) : void
      {
         this.vehicleTypeIcon.x = VEH_TYPE_MIDDLE_X - (this.vehicleTypeIcon.width >> 1);
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehicleSelectRendererEvent(VehicleSelectRendererEvent.RENDERER_CLICK,this._model.dbID,false,true));
      }
   }
}
