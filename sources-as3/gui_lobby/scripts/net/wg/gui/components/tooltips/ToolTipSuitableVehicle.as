package net.wg.gui.components.tooltips
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.SuitableVehicleVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.cyberSport.controls.CSVehicleButton;
   import net.wg.gui.rally.vo.SettingRosterVO;
   import net.wg.gui.rally.vo.VehicleVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   
   public class ToolTipSuitableVehicle extends ToolTipSpecial
   {
       
      
      public var headerTF:TextField = null;
      
      public var notEnoughTF:TextField = null;
      
      public var whiteBg:Sprite = null;
      
      public var alertSuitable:TextField = null;
      
      private var _conditionBtnList:Vector.<CSVehicleButton> = null;
      
      private var _vehicleBlockItems:Vector.<UIComponentEx> = null;
      
      private const MARGIN_BEETWEEN_BLOCKS:Number = 3;
      
      private const MARGIN_AFTER_SUBHEADER:Number = 20;
      
      private const MIN_CONTENT_WIDTH:Number = 275;
      
      private const MAX_CONDITIONS_CS_VEHICLES_BUTTONS:Number = 2;
      
      public function ToolTipSuitableVehicle()
      {
         super();
         this.headerTF = content.headerTF;
         this.notEnoughTF = content.notEnoughTF;
         this.whiteBg = content.whiteBg;
         this.alertSuitable = content.alertSuitable;
         this._conditionBtnList = new Vector.<CSVehicleButton>();
         this._vehicleBlockItems = new Vector.<UIComponentEx>();
         this.addVehicleButtons();
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         super.build(param1,param2);
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipSuitableVehicle " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:UIComponentEx = null;
         var _loc2_:CSVehicleButton = null;
         if(this._conditionBtnList)
         {
            while(this._conditionBtnList.length > 0)
            {
               _loc2_ = this._conditionBtnList.pop();
               _loc2_.dispose();
               content.removeChild(_loc2_);
               _loc2_ = null;
            }
            this._conditionBtnList = null;
         }
         for each(_loc1_ in this._vehicleBlockItems)
         {
            content.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._vehicleBlockItems.splice(0,this._vehicleBlockItems.length);
         this._vehicleBlockItems = null;
         this.headerTF = null;
         this.notEnoughTF = null;
         this.whiteBg = null;
         this.alertSuitable = null;
         super.onDispose();
      }
      
      override protected function redraw() : void
      {
         var _loc2_:SuitableVehicleVO = null;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         var _loc6_:TextField = null;
         var _loc7_:int = 0;
         var _loc8_:uint = 0;
         var _loc9_:TextField = null;
         var _loc1_:ILocale = App.utils.locale;
         _loc2_ = new SuitableVehicleVO(_data);
         var _loc3_:Separator = null;
         separators = new Vector.<Separator>();
         this.headerTF.autoSize = TextFieldAutoSize.LEFT;
         if(!_loc2_.isCreator)
         {
            this.headerTF.htmlText = _loc1_.makeString(_loc2_.toolTipType == TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT ? TOOLTIPS.SUITABLEVEHICLE_HEADER : TOOLTIPS.CSAUTOSEARCHVEHICLE_HEADER);
         }
         else
         {
            this.headerTF.htmlText = _loc1_.makeString(_loc2_.toolTipType == TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT || _loc2_.toolTipType == TOOLTIPS_CONSTANTS.FORT_SORTIE_SLOT ? TOOLTIPS.SUITABLEVEHICLE_CONDITIONSTITLE : TOOLTIPS.CSAUTOSEARCHVEHICLE_CONDITIONSTITLE);
         }
         this.headerTF.width = this.headerTF.textWidth + 5;
         this.headerTF.x = bgShadowMargin.left + contentMargin.left;
         this.headerTF.y = topPosition;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         if(_loc2_.conditions)
         {
            _loc3_ = Utils.instance.createSeparate(content);
            _loc3_.y = topPosition ^ 0;
            separators.push(_loc3_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            if(!_loc2_.isCreator)
            {
               _loc6_ = Utils.instance.addHeader("conditionsHeader",contentMargin.left + bgShadowMargin.left,topPosition,_loc1_.makeString(_loc2_.toolTipType == TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT ? TOOLTIPS.SUITABLEVEHICLE_CONDITIONSTITLE : TOOLTIPS.CSAUTOSEARCHVEHICLE_CONDITIONSTITLE));
               content.addChild(_loc6_);
               topPosition += _loc6_.textHeight + this.MARGIN_AFTER_SUBHEADER ^ 0;
            }
            if(this._conditionBtnList.length < _loc2_.conditions.length && _loc2_.toolTipType == TOOLTIPS_CONSTANTS.FORT_SORTIE_SLOT)
            {
               _loc7_ = this._conditionBtnList.length;
               _loc8_ = _loc2_.conditions.length;
               while(_loc7_++ < _loc8_)
               {
                  this._conditionBtnList.push(this.createVehicleButton());
               }
            }
            _loc5_ = _loc2_.conditions.length;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               if(_loc2_.conditions[_loc4_])
               {
                  topPosition = this.addCondition(content,_loc2_.conditions[_loc4_],topPosition,this._conditionBtnList[_loc4_]);
               }
               _loc4_++;
            }
         }
         if(!_loc2_.isCreator && _loc2_.vehiclesList && _loc2_.vehiclesList.length > 0)
         {
            _loc3_ = Utils.instance.createSeparate(content);
            _loc3_.y = topPosition ^ 0;
            separators.push(_loc3_);
            this.whiteBg.y = _loc3_.y;
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            _loc9_ = Utils.instance.addHeader("suitableHeader",contentMargin.left + bgShadowMargin.left,topPosition,_loc1_.makeString(_loc2_.toolTipType == TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT ? TOOLTIPS.SUITABLEVEHICLE_SUITABLETITLE : TOOLTIPS.CSAUTOSEARCHVEHICLE_SUITABLETITLE));
            content.addChild(_loc9_);
            topPosition += _loc9_.textHeight + this.MARGIN_AFTER_SUBHEADER ^ 0;
            _loc5_ = _loc2_.vehiclesList.length;
            _loc4_ = 0;
            while(_loc4_ < _loc5_)
            {
               topPosition = this.addSuitableVehicleBlockItem(_loc2_.vehiclesList[_loc4_],topPosition);
               _loc4_++;
            }
            this.alertSuitable.x = this.alertSuitable.y = 0;
            this.alertSuitable.width = this.alertSuitable.height = 1;
            this.alertSuitable.visible = false;
         }
         else if(!_loc2_.isCreator)
         {
            _loc3_ = Utils.instance.createSeparate(content);
            _loc3_.y = topPosition ^ 0;
            separators.push(_loc3_);
            this.whiteBg.y = _loc3_.y;
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            this.alertSuitable.multiline = true;
            this.alertSuitable.wordWrap = true;
            this.alertSuitable.autoSize = TextFieldAutoSize.CENTER;
            this.alertSuitable.text = _loc2_.toolTipType == TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT ? TOOLTIPS.SUITABLEVEHICLE_UNSUITABLE : TOOLTIPS.CSAUTOSEARCHVEHICLE_UNSUITABLE;
            this.alertSuitable.textColor = 16719904;
            this.alertSuitable.visible = true;
            this.alertSuitable.x = contentMargin.left + bgShadowMargin.left;
            this.alertSuitable.y = topPosition ^ 0;
            topPosition += this.alertSuitable.textHeight + this.MARGIN_AFTER_SUBHEADER;
         }
         else
         {
            this.alertSuitable.x = this.alertSuitable.y = 0;
            this.alertSuitable.width = this.alertSuitable.height = 1;
            this.alertSuitable.visible = false;
            this.whiteBg.visible = false;
         }
         if((!_loc2_.isCreator || _loc2_.toolTipType == TOOLTIPS_CONSTANTS.FORT_SORTIE_SLOT) && _loc2_.leftCount > 0)
         {
            this.notEnoughTF.htmlText = Utils.instance.htmlWrapper(_loc1_.makeString(_loc2_.toolTipType == TOOLTIPS_CONSTANTS.CYBER_SPORT_SLOT ? TOOLTIPS.SUITABLEVEHICLE_MORE : TOOLTIPS.CSAUTOSEARCHVEHICLE_MORE),Utils.instance.COLOR_ADD_INFO,13,"$TitleFont") + " " + Utils.instance.htmlWrapper(_loc2_.leftCount.toString(),Utils.instance.COLOR_NUMBER,13,"$TitleFont");
            this.notEnoughTF.width = this.notEnoughTF.textWidth + 5;
            this.notEnoughTF.height = this.notEnoughTF.textHeight + 5;
            this.notEnoughTF.y = topPosition;
            this.notEnoughTF.x = bgShadowMargin.left + contentMargin.left;
            this.notEnoughTF.visible = true;
         }
         else
         {
            this.notEnoughTF.x = 0;
            this.notEnoughTF.y = 0;
            this.notEnoughTF.width = 10;
            this.notEnoughTF.visible = false;
         }
         _loc2_.dispose();
         _loc2_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Separator = null;
         if(content.width < this.MIN_CONTENT_WIDTH)
         {
            contentWidth = this.MIN_CONTENT_WIDTH;
         }
         super.updateSize();
         if(this.whiteBg.visible)
         {
            _loc1_ = separators[separators.length - 1];
            this.whiteBg.width = contentWidth + bgShadowMargin.horizontal;
            this.whiteBg.height = content.height + contentMargin.bottom - _loc1_.y;
         }
      }
      
      private function addVehicleButtons() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.MAX_CONDITIONS_CS_VEHICLES_BUTTONS)
         {
            this._conditionBtnList[_loc1_] = this.createVehicleButton();
            _loc1_++;
         }
      }
      
      private function createVehicleButton() : CSVehicleButton
      {
         var _loc1_:CSVehicleButton = App.utils.classFactory.getComponent(Linkages.VEHICLE_BUTTON_UI,CSVehicleButton);
         _loc1_.visible = false;
         _loc1_.enabled = false;
         content.addChild(_loc1_);
         return _loc1_;
      }
      
      private function addCondition(param1:MovieClip, param2:Object, param3:Number, param4:CSVehicleButton) : Number
      {
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(param2.hasOwnProperty("vehicle") && param2["vehicle"])
         {
            _loc5_ = true;
            _loc6_ = true;
         }
         else if(param2.hasOwnProperty("nationIDRange") && param2["nationIDRange"] || param2.hasOwnProperty("vLevelRange") && param2["vLevelRange"] || param2.hasOwnProperty("vTypeRange") && param2["vTypeRange"])
         {
            _loc5_ = true;
         }
         if(_loc5_)
         {
            param4.x = contentMargin.left + bgShadowMargin.left;
            param4.y = (param3 ^ 0) - (Boolean(_data.isCreator) ? 0 : 16);
            param1.addChild(param4);
            param4.showRangeRosterBg = false;
            if(_loc6_)
            {
               param4.setVehicle(new VehicleVO(param2["vehicle"]));
            }
            else
            {
               param4.setRangeData(new SettingRosterVO(param2));
            }
            param4.validateNow();
            param3 += param4.height - 10;
            param4.visible = true;
         }
         return param3;
      }
      
      private function addSuitableVehicleBlockItem(param1:VehicleVO, param2:Number) : Number
      {
         var _loc3_:SuitableVehicleBlockItem = App.utils.classFactory.getComponent("SuitableVehicleBlockItemUI",SuitableVehicleBlockItem);
         this._vehicleBlockItems.push(_loc3_);
         _loc3_.setData(App.utils.nations.getNationIcon(param1.nationID),param1.level,param1.smallIconPath,"../maps/icons/filters/tanks/" + param1.type + ".png",param1.shortUserName);
         _loc3_.x = contentMargin.left + bgShadowMargin.left;
         _loc3_.y = param2 ^ 0;
         content.addChild(_loc3_);
         return Number(param2 + (_loc3_.height + this.MARGIN_BEETWEEN_BLOCKS));
      }
   }
}
