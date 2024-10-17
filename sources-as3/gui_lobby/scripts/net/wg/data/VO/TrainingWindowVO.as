package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class TrainingWindowVO extends DAAPIDataClass
   {
       
      
      public var description:String = "";
      
      public var timeout:Number;
      
      public var minBattleTime:Number;
      
      public var maxBattleTime:Number;
      
      public var arena:Number;
      
      public var privacy:Boolean;
      
      public var create:Boolean;
      
      public var wndTitle:String = "";
      
      public var canMakeOpenedClosed:Boolean;
      
      public var canChangeComment:Boolean;
      
      public var isShowComment:Boolean;
      
      public var canChangeArena:Boolean;
      
      public function TrainingWindowVO(param1:Object)
      {
         super(param1);
      }
   }
}
