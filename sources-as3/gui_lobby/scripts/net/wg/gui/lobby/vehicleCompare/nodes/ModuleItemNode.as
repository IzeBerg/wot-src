package net.wg.gui.lobby.vehicleCompare.nodes
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ModuleItemNode extends ModuleRenderer
   {
      
      private static const EXTRA_ICON_ALPHA:int = 1;
      
      private static const DASHED_STATE:uint = 1048576;
       
      
      public var dashes:Sprite;
      
      public var selector:Sprite;
      
      public var typeIcon:ModuleTypesUIWithFill;
      
      public var levelIcon:MovieClip;
      
      public var nameField:TextField;
      
      private var _tooltipID:String;
      
      public function ModuleItemNode()
      {
         super();
      }
      
      override public function applyData() : void
      {
         var _loc2_:String = null;
         super.applyData();
         this.selector.visible = isSelected();
         this.dashes.visible = this.isDashed();
         var _loc1_:String = getItemName();
         this.nameField.wordWrap = true;
         this.nameField.autoSize = TextFieldAutoSize.CENTER;
         this.nameField.text = _loc1_;
         _loc2_ = getItemType();
         if(_loc2_.length > 0)
         {
            this.typeIcon.visible = true;
            this.typeIcon.setModuleTypeIcon(_loc2_);
         }
         else
         {
            this.typeIcon.visible = false;
         }
         var _loc3_:int = getLevel();
         if(_loc3_ > -1)
         {
            this.levelIcon.gotoAndStop(_loc3_);
         }
         this.applyExtraSourceLoad();
      }
      
      override public function toString() : String
      {
         return "[ResearchItem " + index + ", " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.typeIcon.dispose();
         this.typeIcon = null;
         this.levelIcon = null;
         this.nameField = null;
         this.dashes = null;
         this.selector = null;
         super.onDispose();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         entityType = NodeEntityType.RESEARCH_ITEM;
         this.tooltipID = TOOLTIPS_CONSTANTS.VEH_COMPARE_TECHTREE_MODULE;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler,false,0,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler,false,0,true);
      }
      
      public function isDashed() : Boolean
      {
         return valueObject && (valueObject.state & DASHED_STATE) > 0;
      }
      
      public function set tooltipID(param1:String) : void
      {
         this._tooltipID = param1;
      }
      
      private function applyExtraSourceLoad() : void
      {
         this.typeIcon.hideExtraIcon();
         var _loc1_:String = valueObject.extraInfo;
         if(StringUtils.isNotEmpty(_loc1_))
         {
            this.typeIcon.setExtraIconBySource(_loc1_);
            this.typeIcon.showExtraIcon();
            this.typeIcon.extraIconAlpha = EXTRA_ICON_ALPHA;
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._tooltipID))
         {
            App.toolTipMgr.showSpecial(this._tooltipID,null,valueObject,container != null ? container.rootRenderer.getID() : null);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
