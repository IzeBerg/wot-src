package net.wg.gui.lobby.techtree.interfaces
{
   import net.wg.gui.lobby.techtree.data.NationLevelInfoVO;
   import net.wg.gui.lobby.techtree.data.vo.NationDisplaySettings;
   import net.wg.gui.lobby.techtree.data.vo.NationGridDisplaySettings;
   
   public interface INationTreeDataProvider extends INodesDataProvider
   {
       
      
      function getScrollIndex() : Number;
      
      function getDisplaySettings() : NationDisplaySettings;
      
      function getCommonGridSettings() : NationGridDisplaySettings;
      
      function getPremiumGridSettings() : NationGridDisplaySettings;
      
      function getPremiumLevelInfo() : Vector.<NationLevelInfoVO>;
   }
}
