package net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper
{
   import net.wg.infrastructure.base.meta.IWTEventEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventEntryPointMeta;
   
   public class WTEventEntryPoint extends WTEventEntryPointMeta implements IWTEventEntryPointMeta
   {
       
      
      public function WTEventEntryPoint()
      {
         super();
         setManageSize(true);
      }
   }
}
