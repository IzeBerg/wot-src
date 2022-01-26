package net.wg.gui.lobby.storage.categories.storage.vehicleSelectPopover
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.popovers.events.VehicleSelectRendererEvent;
   import net.wg.infrastructure.interfaces.IImage;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ListItemRenderer;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehicleSelectRenderer extends ListItemRenderer
   {
      
      private static const VEH_TYPE_MIDDLE_X:int = 70;
       
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:IImage;
      
      public var levelIcon:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      private var _model:VehicleSelectPopoverItemVO = null;
      
      public function VehicleSelectRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         this._model = VehicleSelectPopoverItemVO(param1);
         invalidateData();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.flagLoader.dispose();
         this.tankIcon.dispose();
         this._model = null;
         this.vehicleNameTF = null;
         this.levelIcon = null;
         this.vehicleTypeIcon.removeEventListener(Event.CHANGE,this.onVehicleTypeIconChangeHandler);
         this.vehicleTypeIcon.dispose();
         this.vehicleTypeIcon = null;
         this.flagLoader = null;
         this.tankIcon = null;
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
               this.vehicleNameTF.htmlText = this._model.shortUserName;
               this.vehicleTypeIcon.source = this._model.typeIcon;
               this.levelIcon.gotoAndStop(this._model.level);
               this.flagLoader.source = this._model.nationIcon;
               this.tankIcon.source = this._model.smallIconPath;
            }
            this.vehicleNameTF.visible = _loc1_;
            this.vehicleTypeIcon.visible = _loc1_;
            this.levelIcon.visible = _loc1_;
            this.flagLoader.visible = _loc1_;
            this.tankIcon.visible = _loc1_;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(ButtonEvent.CLICK,this.onClickHandler);
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
         dispatchEvent(new VehicleSelectRendererEvent(VehicleSelectRendererEvent.RENDERER_CLICK,this._model.intCD,false,true));
      }
   }
}
