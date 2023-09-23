package net.wg.gui.lobby.components.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class SkillsVO extends DAAPIDataClass
   {
       
      
      public var icon:String = "";
      
      public var name:String = "";
      
      public var desc:String = "";
      
      public var active:Boolean = false;
      
      public var selected:Boolean = false;
      
      public var tankmanID:Number = NaN;
      
      public var buy:Boolean = false;
      
      public var buyCount:int = 0;
      
      public var buyFreeCount:int = 0;
      
      public var showBuyAnimation:Boolean = true;
      
      public var level:Number = -1;
      
      public var id:String = "";
      
      public function SkillsVO(param1:Object = null)
      {
