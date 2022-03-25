package net.wg.gui.battle.views.minimap.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class EpicMinimapEntriesContainer extends MinimapEntriesContainer
   {
       
      
      public var maskTop:MovieClip = null;
      
      public var hqs:Sprite = null;
      
      public var maskBottom:MovieClip = null;
      
      public var zones:Sprite = null;
      
      public var landingZone:Sprite = null;
      
      public var background:UILoaderAlt = null;
      
      public function EpicMinimapEntriesContainer()
      {
         super();
         this.maskTop.mouseEnabled = this.hqs.mouseEnabled = this.maskBottom.mouseEnabled = this.zones.mouseEnabled = this.landingZone.mouseEnabled = this.background.mouseEnabled = false;
         this.maskTop.mouseChildren = this.hqs.mouseChildren = this.maskBottom.mouseChildren = this.zones.mouseChildren = this.landingZone.mouseChildren = this.background.mouseChildren = false;
      }
      
      override protected function onDispose() : void
      {
         this.maskTop = null;
         this.hqs = null;
         this.maskBottom = null;
         this.zones = null;
         this.landingZone = null;
         this.background.dispose();
         this.background = null;
         super.onDispose();
      }
   }
}
