package net.wg.gui.battle.commander.views.spawnMenu
{
   import flash.geom.Rectangle;
   
   public class SizeSettings
   {
      
      private static const _stagesSizeSettings:Object = {
         "extraSmall":new StageSizeSettings(new Rectangle(0,0,1024,705),new Rectangle(0,0,410,410),new Rectangle(0,0,280,41),new Rectangle(0,0,280,40),new Rectangle(0,0,95,60)),
         "small":new StageSizeSettings(new Rectangle(0,0,1366,768),new Rectangle(0,0,480,480),new Rectangle(0,0,280,41),new Rectangle(0,0,280,40),new Rectangle(0,0,95,60)),
         "medium":new StageSizeSettings(new Rectangle(0,0,1600,900),new Rectangle(0,0,550,550),new Rectangle(0,0,320,50),new Rectangle(0,0,320,47),new Rectangle(0,0,110,100)),
         "large":new StageSizeSettings(new Rectangle(0,0,1920,1080),new Rectangle(0,0,600,600),new Rectangle(0,0,320,50),new Rectangle(0,0,320,47),new Rectangle(0,0,110,100))
      };
       
      
      public function SizeSettings()
      {
         super();
      }
      
      public static function getStageSizeSettings(param1:String) : StageSizeSettings
      {
         return _stagesSizeSettings[param1];
      }
   }
}
