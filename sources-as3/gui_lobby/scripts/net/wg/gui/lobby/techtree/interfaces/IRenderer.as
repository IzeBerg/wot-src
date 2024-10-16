package net.wg.gui.lobby.techtree.interfaces
{
   import flash.geom.Point;
   import net.wg.gui.lobby.techtree.data.vo.NodeData;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   
   public interface IRenderer extends ISoundable, IUIComponentEx
   {
       
      
      function setup(param1:uint, param2:NodeData, param3:uint = 0, param4:Object = null) : void;
      
      function getID() : uint;
      
      function getItemName() : String;
      
      function getItemType() : String;
      
      function getGraphicsName() : String;
      
      function getLevel() : int;
      
      function getIconPath() : String;
      
      function isFake() : Boolean;
      
      function getEarnedXP() : Number;
      
      function getDisplayInfo() : Object;
      
      function getInX() : Number;
      
      function getOutX() : Number;
      
      function getY() : Number;
      
      function getRatioY() : Number;
      
      function setPosition(param1:Point) : void;
      
      function getActualWidth() : Number;
      
      function getColorIndex(param1:IRenderer = null) : uint;
      
      function isLocked() : Boolean;
      
      function isNext2Unlock() : Boolean;
      
      function isUnlocked() : Boolean;
      
      function isElite() : Boolean;
      
      function isPremium() : Boolean;
      
      function isCollectible() : Boolean;
      
      function inInventory() : Boolean;
      
      function isTradeIn() : Boolean;
      
      function isActionEnabled() : Boolean;
      
      function canHaveBlueprint() : Boolean;
      
      function isSelected() : Boolean;
      
      function isTopActionNode() : Boolean;
      
      function invalidateNodeState() : void;
      
      function cleanUp() : void;
      
      function getNodeData() : NodeData;
      
      function get index() : uint;
      
      function get entityType() : uint;
      
      function set entityType(param1:uint) : void;
      
      function get nodeState() : String;
      
      function get bottomArrowOffset() : Number;
      
      function get matrixPosition() : Object;
      
      function get container() : INodesContainer;
      
      function set container(param1:INodesContainer) : void;
   }
}
