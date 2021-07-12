package net.wg.gui.components.dogtag
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class DogtagUpPlateVictim extends UIComponentEx
   {
       
      
      public var engraving:UILoaderAlt = null;
      
      public var rankShadowMc:MovieClip = null;
      
      public var plate:UILoaderAlt = null;
      
      public function DogtagUpPlateVictim()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.engraving.dispose();
         this.engraving = null;
         this.rankShadowMc = null;
         this.plate.dispose();
         this.plate = null;
         super.onDispose();
      }
      
      public function setDogTagInfo(param1:String, param2:String) : void
      {
         this.plate.source = param1;
         this.engraving.source = param2;
      }
   }
}
