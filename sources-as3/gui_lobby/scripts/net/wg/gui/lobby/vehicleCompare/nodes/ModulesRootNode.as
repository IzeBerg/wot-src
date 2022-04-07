package net.wg.gui.lobby.vehicleCompare.nodes
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.techtree.constants.NodeEntityType;
   
   public class ModulesRootNode extends ModuleRenderer
   {
      
      private static const NORMAL_STATE:String = "normal";
      
      private static const ELITE_STATE:String = "elite";
      
      private static const ELITE_POSTFIX:String = "_elite";
      
      private static const LEVEL_ELITE_OFFSET:int = 21;
      
      private static const LEVEL_OFFSET:int = 3;
       
      
      public var nameField:TextField;
      
      public var statusTF:TextField;
      
      public var levelIcon:MovieClip;
      
      public var typeIcon:MovieClip;
      
      public var vIconLoader:UILoaderAlt;
      
      public var flag:MovieClip;
      
      public var inHangarIcon:Sprite;
      
      public var hit:MovieClip;
      
      public function ModulesRootNode()
      {
         super();
         enabled = false;
      }
      
      override public function applyData() : void
      {
         super.applyData();
         var _loc1_:String = container.getNation();
         if(this.flag.currentFrameLabel != _loc1_)
         {
            this.flag.gotoAndStop(_loc1_);
         }
         setState(!!isElite() ? ELITE_STATE : NORMAL_STATE);
         this.inHangarIcon.visible = inInventory();
         this.vIconLoader.source = getIconPath();
         this.nameField.htmlText = getItemName();
         this.statusTF.text = this.getStatusLabel();
         this.updateTypeIcon();
         this.updateLevelIcon();
      }
      
      override protected function onDispose() : void
      {
         this.vIconLoader.dispose();
         this.vIconLoader = null;
         this.levelIcon = null;
         this.typeIcon = null;
         this.nameField = null;
         this.flag = null;
         this.statusTF = null;
         this.inHangarIcon = null;
         this.hit = null;
         super.onDispose();
      }
      
      override protected function preInitialize() : void
      {
         super.preInitialize();
         entityType = NodeEntityType.RESEARCH_ROOT;
         _state = NORMAL_STATE;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hit;
         this.nameField.autoSize = TextFieldAutoSize.RIGHT;
      }
      
      private function getStatusLabel() : String
      {
         var _loc1_:String = null;
         if(inInventory())
         {
            _loc1_ = VEH_COMPARE.MODULESVIEW_VEHICLESTATUS_INHANGAR;
         }
         else if(isUnlocked())
         {
            _loc1_ = VEH_COMPARE.MODULESVIEW_VEHICLESTATUS_READYTOBUY;
         }
         else
         {
            _loc1_ = VEH_COMPARE.MODULESVIEW_VEHICLESTATUS_READYTORESEARCH;
         }
         return _loc1_;
      }
      
      private function updateLevelIcon() : void
      {
         var _loc1_:int = getLevel();
         var _loc2_:Boolean = _loc1_ > -1;
         this.levelIcon.visible = _loc2_;
         if(_loc2_)
         {
            this.levelIcon.gotoAndStop(_loc1_);
         }
      }
      
      private function updateTypeIcon() : void
      {
         var _loc3_:Boolean = false;
         var _loc1_:String = getItemType();
         var _loc2_:Boolean = _loc1_.length > 0;
         this.typeIcon.visible = _loc2_;
         if(_loc2_)
         {
            _loc3_ = isElite();
            this.typeIcon.gotoAndStop(_loc1_ + (!!_loc3_ ? ELITE_POSTFIX : ""));
            if(_loc3_)
            {
               this.levelIcon.x = LEVEL_ELITE_OFFSET;
            }
            else
            {
               this.levelIcon.x = Math.round(this.typeIcon.x + this.typeIcon.width + LEVEL_OFFSET);
            }
         }
      }
   }
}
