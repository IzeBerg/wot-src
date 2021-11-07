package net.wg.gui.lobby.components
{
   import net.wg.gui.lobby.components.data.StatisticsLabelLinkageDataVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IStatisticsBodyContainerData extends IDisposable
   {
       
      
      function get dataListVO() : Vector.<StatisticsLabelLinkageDataVO>;
   }
}
