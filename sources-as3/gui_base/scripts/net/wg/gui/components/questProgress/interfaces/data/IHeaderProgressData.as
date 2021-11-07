package net.wg.gui.components.questProgress.interfaces.data
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IHeaderProgressData extends IDisposable
   {
       
      
      function get progressType() : String;
      
      function get orderType() : String;
      
      function get scope() : String;
      
      function get header() : String;
      
      function get valueTitle() : String;
      
      function get value() : int;
      
      function get goal() : int;
      
      function get progress() : Array;
      
      function get state() : int;
      
      function get conditionIcon() : String;
   }
}
