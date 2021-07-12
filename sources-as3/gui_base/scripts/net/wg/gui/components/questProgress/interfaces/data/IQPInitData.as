package net.wg.gui.components.questProgress.interfaces.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQPInitData extends IDisposable
   {
       
      
      function get description() : String;
      
      function get title() : String;
      
      function get iconID() : String;
      
      function get orderType() : String;
      
      function get progressType() : String;
      
      function get topMetricIndex() : int;
      
      function get alertLabel() : String;
      
      function get multiplier() : String;
      
      function get isInOrGroup() : Boolean;
      
      function get isHiddenInBattleHud() : Boolean;
      
      function get tooltip() : String;
   }
}
