package net.wg.gui.lobby.battleResults.components
{
   import flash.events.MouseEvent;
   import net.wg.data.VO.AchievementItemVO;
   import net.wg.data.VO.IconVO;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   
   public class CustomAchievement extends SoundListItemRenderer
   {
      
      protected static const IMG_URL:String = "img://";
      
      private static const LOADER_ALPHA:Number = 0.9;
      
      public static const TYPE_MARK_OF_MASTERY:String = "markOfMastery";
      
      public static const TYPE_MARK_OF_GUN:String = "marksOnGun";
       
      
      public var loader:UILoaderAlt;
      
      public var useBigIcon:Boolean = false;
      
      protected var achievement:AchievementItemVO;
      
      private var _dataDirty:Boolean = false;
      
      public function CustomAchievement()
      {
         super();
      }
      
      override public function canPlaySound(param1:String) : Boolean
      {
         return false;
      }
      
      override public function setData(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         super.setData(param1);
         this.achievement = AchievementItemVO(param1);
         this._dataDirty = true;
         this.drawLoader();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.loader.mouseChildren = false;
         this.loader.buttonMode = false;
         this.buttonMode = false;
      }
      
      override protected function onDispose() : void
      {
         if(this.loader)
         {
            this.loader.dispose();
            this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadCompleteHandler);
            this.loader = null;
         }
         this.achievement = null;
         super.onDispose();
      }
      
      protected function onShowTooltip() : void
      {
         var _loc1_:String = this.getTooltipKeyByItemData(data);
         App.toolTipMgr.showSpecial(_loc1_,null,data.block,data.type,data.rank,data.customData,data.vehicleLevel,data.arenaType);
      }
      
      protected function drawLoader() : void
      {
         var _loc1_:IconVO = null;
         if(this._dataDirty)
         {
            if(this.achievement.isRare)
            {
               this.tryToLoadRareAchievement();
            }
            else
            {
               _loc1_ = this.achievement.icon;
               if(this.loader != null && _loc1_)
               {
                  this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoadCompleteHandler);
                  this.loader.source = !!this.useBigIcon ? _loc1_.big : _loc1_.small;
               }
            }
            this._dataDirty = false;
         }
      }
      
      protected function tryToLoadRareAchievement() : void
      {
         if(this.achievement.rareIconId)
         {
            this.loader.source = IMG_URL + this.achievement.rareIconId;
            this.loader.addEventListener(UILoaderEvent.COMPLETE,this.onLoadCompleteHandler);
         }
      }
      
      protected function onLoadComplete() : void
      {
         this.loader.removeEventListener(UILoaderEvent.COMPLETE,this.onLoadCompleteHandler);
         if(this.achievement.inactive)
         {
            this.changeSaturation();
         }
      }
      
      private function getTooltipKeyByItemData(param1:Object) : String
      {
         var _loc2_:String = null;
         var _loc3_:String = param1.type;
         if(_loc3_ == TYPE_MARK_OF_MASTERY)
         {
            _loc2_ = TOOLTIPS_CONSTANTS.MARK_OF_MASTERY;
         }
         else if(_loc3_ == TYPE_MARK_OF_GUN)
         {
            _loc2_ = TOOLTIPS_CONSTANTS.BATTLE_STATS_MARKS_ON_GUN_ACHIEVEMENT;
         }
         else
         {
            _loc2_ = TOOLTIPS_CONSTANTS.BATTLE_STATS_ACHIEVS;
         }
         return _loc2_;
      }
      
      private function changeSaturation() : void
      {
         this.loader.alpha = LOADER_ALPHA;
         App.utils.commons.setSaturation(this.loader,0);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.onShowTooltip();
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
      
      private function onLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         this.onLoadComplete();
      }
   }
}
