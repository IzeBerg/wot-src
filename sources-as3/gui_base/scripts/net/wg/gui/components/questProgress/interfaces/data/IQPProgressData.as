package net.wg.gui.components.questProgress.interfaces.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IQPProgressData extends IDisposable
   {
       
      
      function cloneObj() : IQPProgressData;
      
      function get state() : int;
      
      function get isHidden() : Boolean;
      
      function get isNotStarted() : Boolean;
      
      function get isCompleted() : Boolean;
      
      function get isConflict() : Boolean;
      
      function get isFailed() : Boolean;
      
      function get isInProgress() : Boolean;
      
      function get isLocked() : Boolean;
      
      function get current() : Number;
      
      function get goal() : Number;
      
      function get metricsValue() : Vector.<IQPMetrics>;
   }
}
