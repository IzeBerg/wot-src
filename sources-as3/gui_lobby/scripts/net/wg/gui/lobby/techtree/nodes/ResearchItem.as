package net.wg.gui.lobby.techtree.nodes
{
   import flash.display.BlendMode;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Aliases;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.data.constants.generated.NODE_STATE_FLAGS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.gui.lobby.techtree.constants.NodeRendererState;
   import net.wg.gui.lobby.techtree.constants.XpTypeStrings;
   import net.wg.gui.lobby.techtree.controls.ActionButton;
   import net.wg.gui.lobby.techtree.controls.XPField;
   import net.wg.gui.lobby.techtree.interfaces.IBorderHighlighted;
   import net.wg.gui.lobby.techtree.interfaces.IResearchContainer;
   import net.wg.gui.lobby.techtree.postProgression.NodeHighlightAnimation;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class ResearchItem extends Renderer implements IBorderHighlighted
   {
      
      private static const EXTRA_ICON_ALPHA_TRANSPARENT:Number = 0.5;
      
      private static const EXTRA_ICON_ALPHA:int = 1;
       
      
      public var lockedModuleHighlight:NodeHighlightAnimation = null;
      
      public var dashes:MovieClip;
      
      public var typeIcon:ModuleTypesUIWithFill;
      
      public var levelIcon:MovieClip;
      
      public var nameField:TextField;
      
      public var button:ActionButton;
      
      public var xpField:XPField;
      
      private var _lastInvalidatedState:uint = 0;
      
      public function ResearchItem()
      {
         super();
      }
      
      override public function getExtraState() : Object
      {
         var _loc1_:Boolean = container != null;
         return {
            "isRootInInventory":(!!_loc1_ ? container.rootRenderer.inInventory() : 0),
            "isParentUnlocked":(!!_loc1_ ? IResearchContainer(container).hasUnlockedParent(matrixPosition.row - 1,index) : false)
         };
      }
      
      override public function invalidateNodeState() : void
      {
         updateStateProps();
         if(Math.abs(this._lastInvalidatedState - valueObject.state) != NODE_STATE_FLAGS.DASHED)
         {
            App.contextMenuMgr.hide();
         }
         invalidateData();
         this._lastInvalidatedState = valueObject.state;
      }
      
      override public function showContextMenu() : void
      {
         if(this.button != null)
         {
            this.button.endAnimation(true);
         }
         App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.RESEARCH_ITEM,this,{
            "nodeCD":valueObject.id,
            "rootCD":container.rootRenderer.getID(),
            "nodeState":valueObject.state,
            "previewAlias":Aliases.RESEARCH
         });
      }
      
      override public function toString() : String
      {
         return "[ResearchItem " + index + ", " + name + "]";
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.STATE))
         {
            this.nameField.blendMode = BlendMode.ADD;
         }
      }
      
      override protected function validateData() : void
      {
         var _loc2_:String = null;
         var _loc4_:Boolean = false;
         var _loc1_:String = getItemName();
         this.nameField.wordWrap = true;
         this.nameField.autoSize = TextFieldAutoSize.CENTER;
         this.nameField.text = _loc1_;
         this.dashes.visible = this.isDashed();
         this.dashes.gotoAndPlay(1);
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
         if(this.xpField)
         {
            _loc4_ = dataInited && (valueObject.state & NODE_STATE_FLAGS.AUTO_UNLOCKED) > 0;
            if(!_loc4_)
            {
               this.xpField.setData(valueObject.unlockProps.xpCost,XpTypeStrings.COST_XP_TYPE);
            }
            this.xpField.visible = !_loc4_;
         }
         if(this.button != null)
         {
            this.button.action = stateProps.action;
            this.button.label = valueObject.costLabel;
            this.button.enabled = isActionEnabled();
            this.button.visible = stateProps.visible;
            this.button.setAnimation(stateProps.id,stateProps.animation);
            this.button.setOwner(this);
         }
         this.applyExtraSource();
         super.validateData();
      }
      
      override protected function onDispose() : void
      {
         if(this.button)
         {
            this.button.dispose();
            this.button = null;
         }
         this.typeIcon.dispose();
         this.typeIcon = null;
         if(this.xpField != null)
         {
            this.xpField.dispose();
            this.xpField = null;
         }
         this.levelIcon = null;
         this.nameField = null;
         this.dashes = null;
         this.lockedModuleHighlight.dispose();
         this.lockedModuleHighlight = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         entityType = NodeEntityType.RESEARCH_ITEM;
         tooltipID = TOOLTIPS_CONSTANTS.TECHTREE_MODULE;
         delegateToChildren();
      }
      
      override protected function addNodeEventHandlers() : void
      {
         super.addNodeEventHandlers();
         hit.addEventListener(MouseEvent.CLICK,this.onHitClickHandler,false,0,true);
      }
      
      override protected function removeNodeEventHandlers() : void
      {
         hit.removeEventListener(MouseEvent.CLICK,this.onHitClickHandler);
         super.removeNodeEventHandlers();
      }
      
      override protected function rollOut() : void
      {
         super.rollOut();
         dispatchEvent(new TechTreeEvent(TechTreeEvent.ON_MODULE_HOVER,nodeState,-1,entityType));
      }
      
      override protected function rollOver() : void
      {
         super.rollOver();
         dispatchEvent(new TechTreeEvent(TechTreeEvent.ON_MODULE_HOVER,nodeState,_index,entityType));
      }
      
      public function isDashed() : Boolean
      {
         return valueObject && (valueObject.state & NODE_STATE_FLAGS.DASHED) > 0;
      }
      
      private function applyExtraSource() : void
      {
         var _loc1_:String = valueObject.extraInfo;
         this.typeIcon.hideExtraIcon();
         if(StringUtils.isNotEmpty(_loc1_))
         {
            this.typeIcon.setExtraIconBySource(_loc1_);
            if(!(this.button && this.button.visible || this.xpField && this.xpField.visible))
            {
               this.typeIcon.showExtraIcon();
               this.typeIcon.extraIconAlpha = nodeState == NodeRendererState.LOCKED ? Number(EXTRA_ICON_ALPHA_TRANSPARENT) : Number(EXTRA_ICON_ALPHA);
            }
         }
      }
      
      override protected function get mouseEnabledChildren() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.mouseEnabledChildren;
         if(this.button)
         {
            _loc1_.push(this.button);
         }
         return _loc1_;
      }
      
      public function get isBorderHighlighted() : Boolean
      {
         return this.lockedModuleHighlight.isHighlighted;
      }
      
      public function set isBorderHighlighted(param1:Boolean) : void
      {
         this.lockedModuleHighlight.isHighlighted = param1;
      }
      
      private function onHitClickHandler(param1:MouseEvent) : void
      {
         if(App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new TechTreeEvent(TechTreeEvent.CLICK_2_OPEN,nodeState,_index,entityType));
         }
      }
   }
}
