package net.wg.gui.lobby.techtree.interfaces
{
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.gui.lobby.techtree.data.vo.UnlockProps;
   import net.wg.gui.lobby.techtree.math.ADG_ItemLevelsBuilder;
   
   public interface IResearchDataProvider extends INodesDataProvider
   {
       
      
      function populate(param1:ADG_ItemLevelsBuilder) : void;
      
      function getDepthOfPath(param1:int) : Number;
      
      function getTopLevelAt(param1:int) : NodeData;
      
      function getTopLevelIndexByID(param1:int) : Number;
      
      function setTopLevelState(param1:Number, param2:Number, param3:Number) : Boolean;
      
      function setTopLevelXP(param1:Number, param2:Number) : Boolean;
      
      function setTopLevelUnlockProps(param1:Number, param2:UnlockProps) : Boolean;
      
      function setTopLevelField(param1:String, param2:Number, param3:Object) : Boolean;
      
      function resolveEntityType(param1:NodeData, param2:Boolean = false) : uint;
      
      function get topLength() : Number;
   }
}
