package net.wg.gui.lobby.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.data.VehicleTitleVO;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class VehicleTitle extends UIComponentEx
   {
      
      private static const SIMPLE_ICON_ACTUAL_WIDTH:int = 32;
      
      private static const ELITE_ICON_ACTUAL_WIDTH:int = 48;
      
      private static const TYPE_ICON_WIDTH:int = 83;
      
      private static const INFO_ICON_X_OFFSET:int = 4;
      
      private static const ROLE_TF_Y_OFFSET_SMALL:int = 0;
      
      private static const ROLE_TF_Y_OFFSET_BIG:int = 9;
       
      
      public var tankTier:TextField = null;
      
      public var tankName:TextField = null;
      
      public var tankType:Image = null;
      
      public var infoIcon:Sprite = null;
      
      public var roleTF:TextField = null;
      
      public var statusTF:TextField = null;
      
      public var hitMc:Sprite = null;
      
      private var _abilityBlock:AbilityBlock = null;
      
      private var _tankTierStr:String = "";
      
      private var _tankNameStr:String = "";
      
      private var _tankTierStrSmall:String = "";
      
      private var _tankNameStrSmall:String = "";
      
      private var _tankTypeIcon:String = "";
      
      private var _statusStr:String = "";
      
      private var _isElite:Boolean = false;
      
      private var _isSmallSized:Boolean = true;
      
      private var _nodeData:NodeData = null;
      
      private var _roleText:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _intCD:uint = 0;
      
      private var _showInfoIcon:Boolean = true;
      
      public function VehicleTitle()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler,false,0,true);
         this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler,false,0,true);
         this.tankType.mouseEnabled = false;
         this.roleTF.visible = false;
         this.roleTF.addEventListener(MouseEvent.ROLL_OVER,this.onRoleTFRollOverHandler);
         this.roleTF.addEventListener(MouseEvent.ROLL_OUT,this.onRoleTFRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
         {
            this.tankType.source = this._tankTypeIcon;
            this.tankTier.htmlText = !!this._isSmallSized ? this._tankTierStrSmall : this._tankTierStr;
            this.tankName.htmlText = !!this._isSmallSized ? this._tankNameStrSmall : this._tankNameStr;
            this.infoIcon.visible = this._showInfoIcon;
            _loc1_ = !StringUtils.isEmpty(this._statusStr);
            _loc2_ = !StringUtils.isEmpty(this._roleText);
            if(_loc1_)
            {
               this.statusTF.htmlText = this._statusStr;
            }
            this.statusTF.visible = _loc1_;
            if(this.tankTier.text == Values.EMPTY_STR)
            {
               this.tankTier.width = 0;
            }
            else
            {
               App.utils.commons.updateTextFieldSize(this.tankTier,true,true);
            }
            App.utils.commons.updateTextFieldSize(this.tankName,true,true);
            this.roleTF.visible = _loc2_ && !_loc1_;
            if(this.roleTF.visible)
            {
               this.roleTF.htmlText = this._roleText;
               App.utils.commons.updateTextFieldSize(this.roleTF,true,true);
            }
            invalidate(InvalidationType.LAYOUT);
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.updateLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
         this.roleTF.removeEventListener(MouseEvent.ROLL_OVER,this.onRoleTFRollOverHandler);
         this.roleTF.removeEventListener(MouseEvent.ROLL_OUT,this.onRoleTFRollOutHandler);
         if(this._abilityBlock)
         {
            this._abilityBlock.dispose();
            this._abilityBlock = null;
         }
         this.tankTier = null;
         this.tankName = null;
         this.tankType.dispose();
         this.tankType = null;
         this.infoIcon = null;
         this.statusTF = null;
         this.roleTF = null;
         this.hitMc = null;
         this._nodeData = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      private function updateAbilityLayout() : void
      {
         var _loc1_:Boolean = false;
         if(this._abilityBlock)
         {
            _loc1_ = this._abilityBlock.isAvailable();
            this._abilityBlock.visible = _loc1_;
            if(_loc1_)
            {
               this._abilityBlock.y = this.roleTF.y + this.roleTF.height;
            }
         }
      }
      
      public function setData(param1:VehicleTitleVO) : void
      {
         this._tankNameStr = param1.tankNameStr;
         this._tankTierStr = param1.tankTierStr;
         this._tankTypeIcon = param1.typeIconPath;
         this._tankNameStrSmall = param1.tankNameStrSmall;
         this._tankTierStrSmall = param1.tankTierStrSmall;
         this._statusStr = param1.statusStr;
         this._isElite = param1.isElite;
         this._roleText = param1.roleText;
         this._intCD = param1.intCD;
         this._showInfoIcon = param1.showInfoIcon;
         if(param1.ability)
         {
            this.createAbilityBlock();
            this._abilityBlock.setData(param1.ability);
         }
         invalidateData();
      }
      
      public function setNodeData(param1:NodeData) : void
      {
         this._nodeData = param1;
      }
      
      private function createAbilityBlock() : void
      {
         if(!this._abilityBlock)
         {
            this._abilityBlock = App.utils.classFactory.getComponent(Linkages.ABILITY_BLOCK,AbilityBlock);
            addChild(this._abilityBlock);
         }
      }
      
      private function updateLayout() : void
      {
         var _loc1_:Number = !!this._showInfoIcon ? Number(this.infoIcon.width + INFO_ICON_X_OFFSET) : Number(0);
         var _loc2_:Number = this._tankTierStr == Values.EMPTY_STR ? Number(0) : (!!this._isElite ? Number(ELITE_ICON_ACTUAL_WIDTH) : Number(SIMPLE_ICON_ACTUAL_WIDTH));
         var _loc3_:Number = this.tankTier.width + this.tankName.width + _loc2_ + _loc1_;
         this.tankTier.x = -_loc3_ >> 1;
         this.tankType.x = this.tankTier.x + this.tankTier.width - (TYPE_ICON_WIDTH - _loc2_ >> 1) | 0;
         this.tankName.x = this.tankTier.x + this.tankTier.width + _loc2_ | 0;
         if(this._showInfoIcon)
         {
            this.infoIcon.x = this.tankName.x + this.tankName.width + INFO_ICON_X_OFFSET | 0;
         }
         this.hitMc.x = this.tankTier.x;
         this.hitMc.y = this.tankTier.y;
         this.hitMc.width = _loc3_;
         this.hitMc.height = this.tankName.height;
         if(this._isSmallSized)
         {
            this.tankName.y = -this.tankName.height | 0;
            this.tankTier.y = -this.tankTier.height | 0;
         }
         else
         {
            this.tankName.y = -this.tankName.textHeight | 0;
            this.tankTier.y = -this.tankTier.textHeight | 0;
         }
         if(this.roleTF.visible)
         {
            this.roleTF.x = -this.roleTF.width >> 1;
            this.roleTF.y = this.tankName.y + this.tankName.textHeight + (!!this._isSmallSized ? ROLE_TF_Y_OFFSET_SMALL : ROLE_TF_Y_OFFSET_BIG) | 0;
         }
         this.updateAbilityLayout();
      }
      
      public function get isSmallSized() : Boolean
      {
         return this._isSmallSized;
      }
      
      public function set isSmallSized(param1:Boolean) : void
      {
         if(param1 == this._isSmallSized)
         {
            return;
         }
         this._isSmallSized = param1;
         invalidateSize();
      }
      
      private function onRoleTFRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onRoleTFRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = !StringUtils.isEmpty(this._roleText);
         if(_loc2_)
         {
            this._tooltipMgr.showWulfTooltip(TOOLTIPS_CONSTANTS.VEHICLE_ROLES,int(Boolean(this._nodeData) ? this._nodeData.id : this._intCD));
         }
      }
      
      private function onInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipMgr && this._nodeData)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE,null,this._nodeData,this._nodeData.id);
         }
         else
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.CAROUSEL_VEHICLE,null,this._intCD);
         }
      }
      
      private function onInfoIconRollOutHandler(param1:MouseEvent) : void
      {
         if(this._tooltipMgr)
         {
            this._tooltipMgr.hide();
         }
      }
   }
}
