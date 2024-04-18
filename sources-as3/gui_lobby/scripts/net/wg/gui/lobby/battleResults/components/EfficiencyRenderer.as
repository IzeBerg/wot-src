package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import net.wg.data.VO.UserVO;
   import net.wg.data.constants.generated.BATTLE_EFFICIENCY_TYPES;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.UserNameField;
   import net.wg.gui.events.FinalStatisticEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class EfficiencyRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const CAPTURE_VALS:String = "captureVals";
      
      private static const DEFENCE_VALS:String = "defenceVals";
      
      private static const NO_STUN_X_PLAYERNAME:int = 136;
      
      private static const NO_STUN_X_VEHNAME:int = 204;
      
      private static const NO_STUN_X_VEHICON:int = 150;
      
      private static const STUN_X_PLAYERNAME:int = 109;
      
      private static const STUN_X_VEHNAME:int = 168;
      
      private static const STUN_X_VEHICON:int = 114;
      
      private static const LEFT_MARGIN:int = 15;
      
      private static const DASH_ELEMENT_STRING:String = "-";
       
      
      public var fakeBg:MovieClip;
      
      public var playerName:UserNameField;
      
      public var vehicleIcon:UILoaderAlt;
      
      public var groupLabelTF:TextField = null;
      
      public var baseNameTF:TextField = null;
      
      public var vehicleName:TextField;
      
      public var killIcon:EfficiencyIconRenderer;
      
      public var damageIcon:EfficiencyIconRenderer;
      
      public var critsIcon:EfficiencyIconRenderer;
      
      public var evilIcon:EfficiencyIconRenderer;
      
      public var spottedIcon:EfficiencyIconRenderer;
      
      public var armorIcon:EfficiencyIconRenderer;
      
      public var baseTotalItemsTF:TextField;
      
      public var baseCaptureIcon:EfficiencyIconRenderer;
      
      public var baseDefenceIcon:EfficiencyIconRenderer;
      
      public var stunIcon:EfficiencyIconRenderer;
      
      public var deadBg:MovieClip;
      
      private var _owner:UIComponent = null;
      
      private var _index:uint = 0;
      
      private var _selectable:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _data:Object;
      
      private var _dataDirty:Boolean = false;
      
      private var _isMouseOver:Boolean = false;
      
      private var _icons:Vector.<EfficiencyIconRenderer>;
      
      private var _iconsLength:uint = 0;
      
      public function EfficiencyRenderer()
      {
         super();
         this._icons = new <EfficiencyIconRenderer>[this.killIcon,this.damageIcon,this.critsIcon,this.evilIcon,this.spottedIcon,this.armorIcon,this.baseCaptureIcon,this.baseDefenceIcon,this.stunIcon];
         this._iconsLength = this._icons.length;
      }
      
      private static function getVehIconFilter() : ColorMatrixFilter
      {
         var _loc1_:ColorMatrixFilter = new ColorMatrixFilter();
         var _loc2_:Array = [0.4,0,0,0,0];
         var _loc3_:Array = [0,0.4,0,0,0];
         var _loc4_:Array = [0,0,0.4,0,0];
         var _loc5_:Array = [0,0,0,1,0];
         var _loc6_:Array = [];
         _loc6_ = _loc6_.concat(_loc2_);
         _loc6_ = _loc6_.concat(_loc3_);
         _loc6_ = _loc6_.concat(_loc4_);
         _loc6_ = _loc6_.concat(_loc5_);
         _loc1_.matrix = _loc6_;
         return _loc1_;
      }
      
      override protected function configUI() : void
      {
         var _loc1_:EfficiencyIconRenderer = null;
         super.configUI();
         focusTarget = this.owner;
         _focusable = tabEnabled = tabChildren = false;
         mouseChildren = true;
         var _loc2_:int = 0;
         while(_loc2_ < this._iconsLength)
         {
            _loc1_ = this._icons[_loc2_];
            _loc1_.visible = false;
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
            _loc2_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:EfficiencyIconRenderer = null;
         for each(_loc1_ in this._icons)
         {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler);
            _loc1_.dispose();
         }
         this._icons.splice(0,this._iconsLength);
         this._icons = null;
         this.playerName.dispose();
         this.vehicleIcon.dispose();
         this.groupLabelTF = null;
         this.baseNameTF = null;
         this.fakeBg = null;
         this._data = null;
         this._owner = null;
         this.playerName = null;
         this.vehicleIcon = null;
         this.vehicleName = null;
         this.killIcon = null;
         this.damageIcon = null;
         this.critsIcon = null;
         this.evilIcon = null;
         this.spottedIcon = null;
         this.armorIcon = null;
         this.baseTotalItemsTF = null;
         this.baseCaptureIcon = null;
         this.baseDefenceIcon = null;
         this.deadBg = null;
         this.stunIcon = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._dataDirty)
         {
            if(this._data != null)
            {
               if(this._data.groupLabel)
               {
                  this.setGroupLabelData();
               }
               else if(!this._data.groupLabel && !this._data.baseLabel)
               {
                  this.setTechniquesData();
                  this.checkMouseOverOnScroll();
               }
               else
               {
                  this.setBasesData();
                  this.checkMouseOverOnScroll();
               }
            }
            this.visible = this._data != null;
            this._dataDirty = false;
         }
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = param1;
         if(param1 != null)
         {
            if(this._data.hoveredKind)
            {
               this._data.hoveredKind = null;
            }
         }
         this._dataDirty = true;
         mouseEnabled = false;
         invalidate();
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         this.selected = param1.selected;
      }
      
      private function setGroupLabelData() : void
      {
         this.hideIcons();
         this.vehicleIcon.visible = false;
         this.deadBg.visible = false;
         this.fakeBg.visible = false;
         this.vehicleName.visible = false;
         this.playerName.visible = false;
         this.baseNameTF.visible = false;
         this.baseTotalItemsTF.visible = false;
         this.groupLabelTF.visible = true;
         this.groupLabelTF.htmlText = this._data.groupLabel;
      }
      
      private function setTechniquesData() : void
      {
         this.groupLabelTF.visible = false;
         this.playerName.visible = true;
         this.playerName.textColor = 13224374;
         this.vehicleName.textColor = 13224374;
         this.vehicleIcon.visible = !this._data.isFake;
         this.deadBg.visible = false;
         this.fakeBg.visible = this._data.isFake;
         this.vehicleName.visible = !this._data.isFake;
         this.killIcon.visible = !this._data.isFake;
         this.armorIcon.visible = !this._data.isFake && !this._data.isAlly;
         this.damageIcon.visible = !this._data.isFake && !this._data.isAlly;
         this.critsIcon.visible = !this._data.isFake && !this._data.isAlly;
         this.evilIcon.visible = !this._data.isFake && !this._data.isAlly;
         this.spottedIcon.visible = !this._data.isFake && !this._data.isAlly;
         if(this._data.isStunDataEnabled)
         {
            this.stunIcon.visible = !this._data.isFake && !this._data.isAlly;
            this.vehicleIcon.x = STUN_X_VEHICON;
            this.vehicleName.x = STUN_X_VEHNAME;
            if(this.playerName.width != STUN_X_PLAYERNAME)
            {
               this.playerName.width = STUN_X_PLAYERNAME;
            }
         }
         else
         {
            this.vehicleIcon.x = NO_STUN_X_VEHICON;
            this.vehicleName.x = NO_STUN_X_VEHNAME;
            if(this.playerName.width != NO_STUN_X_PLAYERNAME)
            {
               this.playerName.width = NO_STUN_X_PLAYERNAME;
            }
            this.stunIcon.visible = false;
         }
         this.baseTotalItemsTF.visible = false;
         this.baseCaptureIcon.visible = false;
         this.baseDefenceIcon.visible = false;
         this.baseNameTF.visible = false;
         this.playerName.userVO = new UserVO({
            "userName":this._data.playerRealName,
            "clanAbbrev":this._data.playerClan,
            "fullName":this._data.playerFullName,
            "region":this._data.playerRegion,
            "fakeName":this._data.playerFakeName
         });
         this.playerName.useFakeName = true;
         var _loc1_:TextFormat = this.playerName.textField.getTextFormat();
         if(this._data.isFake)
         {
            _loc1_.align = TextFormatAlign.LEFT;
            _loc1_.leftMargin = LEFT_MARGIN;
            this.playerName.textField.setTextFormat(_loc1_);
         }
         else
         {
            _loc1_.align = TextFormatAlign.RIGHT;
            _loc1_.leftMargin = 0;
            this.playerName.textField.setTextFormat(_loc1_);
            this.vehicleIcon.source = this._data.tankIcon;
            this.vehicleName.htmlText = this._data.vehicleName;
            this.damageIcon.enabled = false;
            this.critsIcon.enabled = false;
            this.evilIcon.enabled = false;
            this.spottedIcon.enabled = false;
            this.armorIcon.enabled = false;
            this.stunIcon.enabled = false;
            this.killIcon.enabled = false;
            this.killIcon.kind = Boolean(this._data.isAlly) ? BATTLE_EFFICIENCY_TYPES.TEAM_DESTRUCTION : BATTLE_EFFICIENCY_TYPES.DESTRUCTION;
            this.killIcon.enabled = this._data.killCount > 0;
            this.killIcon.value = this._data.killCount;
            if(this._data.deathReason > -1)
            {
               this.playerName.textColor = 6381391;
               this.vehicleName.textColor = 6381391;
               this.deadBg.visible = true;
               this.vehicleIcon.filters = [getVehIconFilter()];
            }
            else
            {
               this.vehicleIcon.filters = [];
            }
            if(this._data.damageDealt > 0)
            {
               this.damageIcon.enabled = true;
               this.damageIcon.value = this._data.piercings;
            }
            if(this._data.critsCount > 0)
            {
               this.critsIcon.enabled = true;
               this.critsIcon.value = this._data.critsCount;
            }
            if(this._data.armorTotalItems > 0)
            {
               this.armorIcon.enabled = true;
               this.armorIcon.value = this._data.armorTotalItems;
            }
            this.evilIcon.enabled = this._data.damageAssisted > 0;
            this.spottedIcon.enabled = this._data.spotted > 0;
            if(this._data.isStunDataEnabled)
            {
               if(this._data.stunTotalItems > 0)
               {
                  this.stunIcon.enabled = true;
                  this.stunIcon.value = this._data.stunTotalItems;
               }
            }
         }
      }
      
      private function setBasesData() : void
      {
         this.groupLabelTF.visible = false;
         this.vehicleIcon.visible = false;
         this.deadBg.visible = false;
         this.fakeBg.visible = false;
         this.vehicleName.visible = false;
         this.playerName.visible = false;
         this.stunIcon.visible = false;
         this.baseNameTF.visible = true;
         this.baseNameTF.htmlText = this._data.baseLabel;
         this.hideIcons();
         this.baseCaptureIcon.visible = this._data.isEnemyBase;
         this.baseDefenceIcon.visible = !this._data.isEnemyBase;
         var _loc1_:Boolean = this._data.hasOwnProperty(CAPTURE_VALS) && this._data.captureVals != null;
         var _loc2_:Boolean = this._data.hasOwnProperty(DEFENCE_VALS) && this._data.defenceVals != null;
         this.baseCaptureIcon.enabled = _loc1_ && this._data.captureVals > 0;
         this.baseDefenceIcon.enabled = _loc2_ && this._data.defenceVals > 0;
         if(_loc1_ && this._data.captureVals >= 0)
         {
            this.baseTotalItemsTF.text = this._data.captureTotalItems;
         }
         else if(_loc2_ && this._data.defenceVals >= 0)
         {
            this.baseTotalItemsTF.text = this._data.defenceTotalItems;
         }
         else
         {
            this.baseTotalItemsTF.text = DASH_ELEMENT_STRING;
         }
         this.baseTotalItemsTF.visible = true;
      }
      
      private function hideIcons() : void
      {
         var _loc1_:EfficiencyIconRenderer = null;
         var _loc2_:int = 0;
         while(_loc2_ < this._iconsLength)
         {
            _loc1_ = this._icons[_loc2_];
            _loc1_.visible = false;
            _loc2_++;
         }
      }
      
      private function checkMouseOverOnScroll() : void
      {
         var _loc2_:EfficiencyIconRenderer = null;
         var _loc1_:Point = new Point(mouseX,mouseY);
         _loc1_ = this.localToGlobal(_loc1_);
         var _loc3_:int = 0;
         while(_loc3_ < this._iconsLength)
         {
            _loc2_ = this._icons[_loc3_];
            if(this._isMouseOver && _loc2_.hitTestPoint(_loc1_.x,_loc1_.y,true))
            {
               this._data.isDisabled = !_loc2_.enabled;
               this._data.hoveredKind = _loc2_.kind;
               dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER,this._data));
            }
            _loc3_++;
         }
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
      }
      
      private function onIconRollOverHandler(param1:MouseEvent) : void
      {
         this._data.isDisabled = !param1.target.enabled;
         this._data.hoveredKind = param1.target.kind;
         dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OVER,this._data));
         this._isMouseOver = true;
      }
      
      private function onIconRollOutHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new FinalStatisticEvent(FinalStatisticEvent.EFFICIENCY_ICON_ROLL_OUT));
         this._isMouseOver = false;
      }
   }
}
