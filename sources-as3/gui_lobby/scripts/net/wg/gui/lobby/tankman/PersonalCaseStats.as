package net.wg.gui.lobby.tankman
{
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.carousels.AchievementCarousel;
   import net.wg.gui.components.carousels.CarouselBase;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalCaseStats extends UIComponentEx implements IViewStackContent
   {
       
      
      public var blocksArea:PersonalCaseBlocksArea = null;
      
      public var achievements:AchievementCarousel = null;
      
      public var achivsBg:MovieClip = null;
      
      public var firstIcon:UILoaderAlt = null;
      
      public var firstMsg:TextField = null;
      
      public var secondIcon:UILoaderAlt = null;
      
      public var secondMsg:TextField = null;
      
      private var data:Object = null;
      
      public function PersonalCaseStats()
      {
         super();
         this.firstIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREM_SMALL_ICON;
         this.secondIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_PREM_CHECKBOX;
      }
      
      public function update(param1:Object) : void
      {
         if(param1 == null)
         {
            return;
         }
         this.data = param1;
         if(param1.achievements.length > 0)
         {
            this.achievements.dataProvider = new DataProvider(this.data.achievements);
            this.achievements.invalidate(CarouselBase.INIT_CAROUSEL);
            this.achivsBg.visible = false;
         }
         this.blocksArea.setData(param1.stats);
         this.firstMsg.htmlText = param1.firstMsg;
         this.secondMsg.htmlText = param1.secondMsg;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      override protected function onDispose() : void
      {
         this.achivsBg = null;
         this.firstMsg = null;
         this.secondMsg = null;
         this.firstIcon.dispose();
         this.firstIcon = null;
         this.secondIcon.dispose();
         this.secondIcon = null;
         if(this.achievements)
         {
            this.achievements.dispose();
            this.achievements = null;
         }
         if(this.blocksArea)
         {
            this.blocksArea.dispose();
            this.blocksArea = null;
         }
         this.data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.achievements.visible = false;
      }
   }
}
