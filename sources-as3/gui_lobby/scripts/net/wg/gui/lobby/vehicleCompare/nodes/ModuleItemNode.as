package net.wg.gui.lobby.vehicleCompare.nodes
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.ModuleTypesUIWithFill;
   import net.wg.gui.lobby.modulesPanel.components.ExtraIcon;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   import net.wg.infrastructure.events.IconLoaderEvent;
   
   public class ModuleItemNode extends ModuleRenderer
   {
      
      private static const DEFAULT_EXTRA_ICON_X:int = 41;
      
      private static const DEFAULT_EXTRA_ICON_Y:int = 41;
      
      private static const EXTRA_ICON_X_SHIFT:int = 2;
      
      private static const EXTRA_ICON_Y_SHIFT:int = 2;
      
      private static const EXTRA_ICON_ALPHA:Number = 1;
      
      private static const DASHED_STATE:uint = 1048576;
       
      
      public var dashes:Sprite;
      
      public var selector:Sprite;
      
      public var typeIcon:ModuleTypesUIWithFill;
      
      public var levelIcon:MovieClip;
      
      public var nameField:TextField;
      
      private var _extraIcon:ExtraIcon;
      
      private var _tooltipID:String = null;
      
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
         this.applyExtraSource();
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
         if(this._extraIcon != null)
         {
            this._extraIcon.removeEventListener(IconLoaderEvent.ICON_LOADED,this.onExtraIconLoadedHandler);
            this._extraIcon.dispose();
            this._extraIcon = null;
         }
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
      
      private function applyExtraSource() : void
      {
         var _loc1_:String = valueObject.extraInfo;
         this.typeIcon.hideExtraIcon();
         switch(_loc1_)
         {
            case RES_ICONS.MAPS_ICONS_MODULES_MAGAZINEGUNICON:
               this.setExtraIcon(Linkages.MAGAZINE_GUN_ICON);
               break;
            case RES_ICONS.MAPS_ICONS_MODULES_HYDRAULICCHASSISICON:
               this.setExtraIcon(Linkages.HYDRAULIC_CHASSIS_ICON);
               break;
            case RES_ICONS.MAPS_ICONS_MODULES_AUTOLOADERGUN:
               this.setExtraIcon(Linkages.AUTOLOADED_GUN_ICON);
               break;
            default:
               this.applyExtraSourceLoad();
         }
      }
      
      private function setExtraIcon(param1:String) : void
      {
         this.typeIcon.setExtraIconByLinkage(param1);
         this.typeIcon.extraIconX = DEFAULT_EXTRA_ICON_X;
         this.typeIcon.extraIconY = DEFAULT_EXTRA_ICON_Y;
         this.typeIcon.showExtraIcon();
         this.typeIcon.extraIconAlpha = EXTRA_ICON_ALPHA;
      }
      
      private function applyExtraSourceLoad() : void
      {
         var _loc1_:String = valueObject.extraInfo;
         if(!this._extraIcon && _loc1_ != null && _loc1_ != "")
         {
            this._extraIcon = new ExtraIcon();
            this._extraIcon.addEventListener(IconLoaderEvent.ICON_LOADED,this.onExtraIconLoadedHandler,false,0,true);
            this._extraIcon.visible = false;
            addChild(this._extraIcon);
         }
         if(this._extraIcon)
         {
            this._extraIcon.setSource(_loc1_);
            this._extraIcon.visible = true;
            if(this._extraIcon.visible)
            {
               this._extraIcon.alpha = EXTRA_ICON_ALPHA;
            }
         }
      }
      
      public function set tooltipID(param1:String) : void
      {
         this._tooltipID = param1;
      }
      
      private function onExtraIconLoadedHandler(param1:IconLoaderEvent) : void
      {
         this._extraIcon.x = this.typeIcon.x + this.typeIcon.width - this._extraIcon.width - EXTRA_ICON_X_SHIFT;
         this._extraIcon.y = this.typeIcon.y + this.typeIcon.height - this._extraIcon.height - EXTRA_ICON_Y_SHIFT;
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipID)
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
