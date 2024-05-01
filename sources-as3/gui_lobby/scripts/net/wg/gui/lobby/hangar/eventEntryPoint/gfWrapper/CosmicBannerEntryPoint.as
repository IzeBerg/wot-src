package net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper
{
   import net.wg.infrastructure.base.meta.ICosmicBannerEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.CosmicBannerEntryPointMeta;
   
   public class CosmicBannerEntryPoint extends CosmicBannerEntryPointMeta implements ICosmicBannerEntryPointMeta
   {
       
      
      public function CosmicBannerEntryPoint()
      {
         super();
         setManageSize(true);
      }
   }
}
