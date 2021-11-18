package net.wg.gui.login.impl.vo
{
   public class FilledLoginFormVo extends FormBaseVo
   {
       
      
      public var userName:String = "";
      
      public var icoPath:String = "";
      
      public var haveToken:Boolean = false;
      
      public var socialId:String = "";
      
      public function FilledLoginFormVo(param1:Object)
      {
         super(param1);
      }
   }
}
