package net.wg.gui.components.paginator.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ToolTipVO extends DAAPIDataClass
   {
       
      
      public var tooltip:String = "";
      
      public var specialArgs:Array = null;
      
      public var specialAlias:String = "";
      
      public var isSpecial:Boolean = false;
      
      public function ToolTipVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.specialArgs != null)
         {
            this.specialArgs.splice(0,this.specialArgs.length);
            this.specialArgs = null;
         }
         super.onDispose();
      }
   }
}
