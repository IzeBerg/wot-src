package net.wg.gui.lobby.ny2020
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TableRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.rally.vo.VehicleVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class NYSelectVehicleRenderer extends TableRenderer
   {
      
      private static const SELECTED_BACKGROUND_OFFSET:int = 11;
       
      
      public var flagLoader:UILoaderAlt;
      
      public var tankIcon:UILoaderAlt;
      
      public var vehicleTypeIcon:MovieClip;
      
      public var selectedMc:MovieClip;
      
      public var selectedBg:MovieClip;
      
      public var vehicleNameTF:TextField;
      
      public var hit:Sprite = null;
      
      private var _model:VehicleVO;
      
      public function NYSelectVehicleRenderer()
      {
         super();
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this._model = VehicleVO(param1);
         invalidateData();
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         return statesDefault;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setSelectedVisible(selected && enabled);
         this.hitArea = this.hit;
         mouseChildren = true;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = this._model != null;
            if(_loc1_)
            {
               this.vehicleNameTF.htmlText = this._model.shortUserName;
               this.vehicleTypeIcon.gotoAndStop(this._model.type);
               this.flagLoader.source = App.utils.nations.getNationIcon(this._model.nationID);
               this.tankIcon.source = this._model.smallIconPath;
               this.enabled = this._model.enabled;
            }
            visible = _loc1_;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.selectedMc.width = _width;
            this.selectedBg.width = _width + SELECTED_BACKGROUND_OFFSET;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.flagLoader.dispose();
         this.flagLoader = null;
         this.tankIcon.dispose();
         this.tankIcon = null;
         this.vehicleNameTF = null;
         this.vehicleTypeIcon = null;
         this.selectedMc = null;
         this.selectedBg = null;
         this._model = null;
         this.hit = null;
         super.onDispose();
      }
      
      public function hideTooltip() : void
      {
         App.toolTipMgr.hide();
      }
      
      private function setSelectedVisible(param1:Boolean) : void
      {
         this.selectedMc.visible = param1;
         this.selectedBg.visible = param1;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(param1 == super.selected)
         {
            return;
         }
         this.setSelectedVisible(param1 && enabled);
         super.selected = param1;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == super.enabled)
         {
            return;
         }
         super.enabled = buttonMode = param1;
         mouseChildren = true;
      }
   }
}
