package net.wg.gui.battle.battleloading.vo
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LoadingFormDisplayDataVO implements IDisposable
   {
       
      
      public var leftRendererId:String = "";
      
      public var rightRendererId:String = "";
      
      public var leftListLeft:int;
      
      public var rightListLeft:int;
      
      public var leftTeamTitleLeft:int;
      
      public var rightTeamTitleLeft:int;
      
      public var tipTitleTop:int;
      
      public var tipBodyTop:int;
      
      public var showTableBackground:Boolean = false;
      
      public var showTipsBackground:Boolean = false;
      
      public function LoadingFormDisplayDataVO()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
   }
}
