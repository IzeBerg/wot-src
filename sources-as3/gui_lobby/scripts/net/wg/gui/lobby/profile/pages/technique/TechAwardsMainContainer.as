package net.wg.gui.lobby.profile.pages.technique
{
   import flash.events.Event;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import net.wg.gui.lobby.profile.pages.awards.AwardsMainContainer;
   import net.wg.utils.ILocale;
   
   public class TechAwardsMainContainer extends AwardsMainContainer
   {
       
      
      public var blockMarksOnGun:AwardsTileListBlock;
      
      public var blockRank:AwardsTileListBlock;
      
      public function TechAwardsMainContainer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:ILocale = App.utils.locale;
         this.blockMarksOnGun.labelText = _loc1_.makeString(PROFILE.SECTION_AWARDS_LABELS_MARKSONGUN);
         this.blockRank.labelText = RANKED_BATTLES.STATISTIC_VEHICLERANK;
         blocks.unshift(this.blockMarksOnGun);
         blocks.unshift(this.blockRank);
         this.blockMarksOnGun.visible = false;
         this.blockMarksOnGun.addEventListener(Event.RESIZE,this.onBlockResizeHandler,false,0,true);
         this.blockRank.visible = false;
         this.blockRank.addEventListener(Event.RESIZE,this.onBlockResizeHandler,false,0,true);
      }
      
      override protected function onDispose() : void
      {
         this.blockMarksOnGun.removeEventListener(Event.RESIZE,this.onBlockResizeHandler);
         this.blockRank.removeEventListener(Event.RESIZE,this.onBlockResizeHandler);
         super.onDispose();
         this.blockMarksOnGun = null;
         this.blockRank = null;
      }
      
      private function onBlockResizeHandler(param1:Event) : void
      {
         param1.stopPropagation();
         updateSize();
      }
   }
}
