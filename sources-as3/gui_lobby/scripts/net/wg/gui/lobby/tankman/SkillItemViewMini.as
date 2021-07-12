package net.wg.gui.lobby.tankman
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.SKILLS_CONSTANTS;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SkillItemViewMini extends UIComponentEx
   {
      
      private static const LEVEL_POSTFIX:String = "%";
      
      private static const COUNT_POSTFIX:String = " x 100%";
       
      
      public var icon:UILoaderAlt;
      
      public var textField:TextField;
      
      private var _text:String = "";
      
      private var _level:Number = 0;
      
      private var _count:int = 0;
      
      private var _type:String;
      
      public function SkillItemViewMini()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.textField = null;
         super.onDispose();
      }
      
      protected function updateType() : void
      {
         if(this._type == SKILLS_CONSTANTS.TYPE_CURRENT_NEW_SKILL || this._type == SKILLS_CONSTANTS.TYPE_NEW_SKILL || this._type == SKILLS_CONSTANTS.TYPE_NEW_SKILLS)
         {
            this.iconSource = null;
         }
         gotoAndPlay(this._type);
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
         this.textField.htmlText = this._text;
      }
      
      public function get level() : Number
      {
         return this._level;
      }
      
      public function set level(param1:Number) : void
      {
         this._level = param1;
         this.text = !!isNaN(this._level) ? Values.EMPTY_STR : this._level.toString() + LEVEL_POSTFIX;
      }
      
      public function get count() : int
      {
         return this._count;
      }
      
      public function set count(param1:int) : void
      {
         this._count = param1;
         this.text = this._count.toString() + COUNT_POSTFIX;
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function set type(param1:String) : void
      {
         if(this._type == param1)
         {
            return;
         }
         this._type = param1;
         this.updateType();
      }
      
      public function get iconSource() : String
      {
         return this.icon.source;
      }
      
      public function set iconSource(param1:String) : void
      {
         this.icon.source = param1;
         this.icon.visible = Boolean(param1);
      }
   }
}
