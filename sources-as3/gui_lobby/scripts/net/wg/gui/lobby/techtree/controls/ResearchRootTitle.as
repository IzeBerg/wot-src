package net.wg.gui.lobby.techtree.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.techtree.data.ResearchRootVO;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResearchRootTitle extends UIComponentEx
   {
      
      private static const SIMPLE_ICON_ACTUAL_WIDTH:int = 32;
      
      private static const ELITE_ICON_ACTUAL_WIDTH:int = 48;
      
      private static const TYPE_ICON_WIDTH:int = 83;
      
      private static const INFO_ICON_X_OFFSET:int = 4;
      
      private static const ROLE_TF_X_OFFSET:int = 9;
       
      
      public var tankTier:TextField = null;
      
      public var tankName:TextField = null;
      
      public var tankType:Image = null;
      
      public var infoIcon:Sprite = null;
      
      public var roleTF:TextField = null;
      
      public var statusTF:TextField = null;
      
      public var hitMc:Sprite = null;
      
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
      
      public function ResearchRootTitle()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hitMc;
         this.addEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler,false,0,true);
         this.addEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler,false,0,true);
         this.tankType.mouseEnabled = this.tankType.mouseChildren = false;
         this.roleTF.mouseEnabled = false;
         this.roleTF.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA,InvalidationType.SIZE))
         {
            this.tankType.source = this._tankTypeIcon;
            this.tankTier.htmlText = !!this._isSmallSized ? this._tankTierStrSmall : this._tankTierStr;
            this.tankName.htmlText = !!this._isSmallSized ? this._tankNameStrSmall : this._tankNameStr;
            if(StringUtils.isEmpty(this._statusStr))
            {
               this.statusTF.visible = false;
            }
            else
            {
               this.statusTF.htmlText = this._statusStr;
               this.statusTF.visible = true;
            }
            App.utils.commons.updateTextFieldSize(this.tankTier,true,true);
            App.utils.commons.updateTextFieldSize(this.tankName,true,true);
            this.roleTF.visible = StringUtils.isNotEmpty(this._roleText);
            if(this.roleTF.visible)
            {
               this.roleTF.htmlText = this._roleText;
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
         this.removeEventListener(MouseEvent.ROLL_OVER,this.onInfoIconRollOverHandler);
         this.removeEventListener(MouseEvent.ROLL_OUT,this.onInfoIconRollOutHandler);
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
      
      public function setData(param1:ResearchRootVO) : void
      {
         this._tankNameStr = param1.tankNameStr;
         this._tankTierStr = param1.tankTierStr;
         this._tankTypeIcon = param1.typeIconPath;
         this._tankNameStrSmall = param1.tankNameStrSmall;
         this._tankTierStrSmall = param1.tankTierStrSmall;
         this._statusStr = param1.statusStr;
         this._isElite = param1.isElite;
         this._roleText = param1.roleText;
         invalidateData();
      }
      
      public function setNodeData(param1:NodeData) : void
      {
         this._nodeData = param1;
      }
      
      private function updateLayout() : void
      {
         var _loc1_:Number = !!this._isElite ? Number(ELITE_ICON_ACTUAL_WIDTH) : Number(SIMPLE_ICON_ACTUAL_WIDTH);
         var _loc2_:Number = this.tankTier.width + this.tankName.width + _loc1_ + this.infoIcon.width + INFO_ICON_X_OFFSET;
         this.tankTier.x = -_loc2_ >> 1;
         this.tankType.x = this.tankTier.x + this.tankTier.width - (TYPE_ICON_WIDTH - _loc1_ >> 1) | 0;
         this.tankName.x = this.tankTier.x + this.tankTier.width + _loc1_ | 0;
         this.infoIcon.x = this.tankName.x + this.tankName.width + INFO_ICON_X_OFFSET | 0;
         this.hitMc.x = this.tankTier.x;
         this.hitMc.y = this.tankTier.y;
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
            this.roleTF.y = this.tankName.y + this.tankName.textHeight + ROLE_TF_X_OFFSET | 0;
         }
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
      
      private function onInfoIconRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipMgr && this._nodeData)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.TECHTREE_VEHICLE,null,this._nodeData,this._nodeData.id);
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
